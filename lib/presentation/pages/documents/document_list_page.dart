import 'dart:convert';

import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/documents.dart/document_bloc.dart';
import 'package:esign/presentation/bloc/documents.dart/document_event.dart';
import 'package:esign/presentation/bloc/documents.dart/document_state.dart';
import 'package:esign/presentation/pages/documents/document_sign_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentListPage extends StatefulWidget {
  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<DocumentBloc>().add(GetDocuments(userId: authState.user.id));
    }
  }

  void _loadDocuments() {
    try {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthSuccess) {
        print('Loading documents for user: ${authState.user.id}'); // Debug log
        context
            .read<DocumentBloc>()
            .add(GetDocuments(userId: authState.user.id));
      }
    } catch (e) {
      print('Error loading documents: $e'); // Debug log
    }
  }

  Future<void> _uploadDocument() async {
    try {
      setState(() => _isUploading = true);

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final fileBytes = file.bytes;

        if (fileBytes != null) {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthSuccess) {
            context.read<DocumentBloc>().add(
                  UploadDocuments(
                    userId: authState.user.id,
                    fileName: file.name,
                    fileUrl:
                        'data:${file.extension == 'pdf' ? 'application/pdf' : 'application/msword'};base64,${base64Encode(fileBytes)}',
                  ),
                );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dokumen berhasil diupload')),
            );
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {
        if (state is DocumentError) {
          print('Document Error: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        print('Current State: $state');
        return Scaffold(
          appBar: AppBar(title: const Text('Dokumen Saya')),
          body: state is DocumentLoading || _isUploading
              ? const Center(child: CircularProgressIndicator())
              : state is DocumentLoaded
                  ? ListView.builder(
                      itemCount: state.documents.length,
                      itemBuilder: (context, index) {
                        final document = state.documents[index];
                        return ListTile(
                          title: Text(document.fileName),
                          subtitle: Text(document.createdAt.toString()),
                          trailing: document.signedUrl != null
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : null,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocumentSignPage(
                                document: document,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('Tidak ada dokumen')),
          floatingActionButton: FloatingActionButton(
            onPressed: _isUploading ? null : _uploadDocument,
            child: _isUploading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
