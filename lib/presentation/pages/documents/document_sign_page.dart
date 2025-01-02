import 'dart:convert';
import 'dart:io';

import 'package:esign/domain/entities/document.dart';
import 'package:esign/presentation/bloc/documents.dart/document_bloc.dart';
import 'package:esign/presentation/bloc/documents.dart/document_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class DocumentSignPage extends StatefulWidget {
  final Document document;

  const DocumentSignPage({Key? key, required this.document}) : super(key: key);

  @override
  State<DocumentSignPage> createState() => _DocumentSignPageState();
}

class _DocumentSignPageState extends State<DocumentSignPage> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  String? _pdfPath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Extract base64 from data URL
      final base64Data = widget.document.fileUrl.split(',')[1];
      final bytes = base64Decode(base64Data);

      // Save to temporary file
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${widget.document.fileName}');
      await file.writeAsBytes(bytes);

      setState(() {
        _pdfPath = file.path;
      });
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document.fileName),
      ),
      body: Column(
        children: [
          Expanded(
            child: _pdfPath != null
                ? PDFView(
                    filePath: _pdfPath!,
                    enableSwipe: true,
                    autoSpacing: true,
                    pageSnap: true,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => _signatureController.clear(),
                      child: const Text('Clear'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_signatureController.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please draw your signature'),
                            ),
                          );
                          return;
                        }

                        final bytes = await _signatureController.toPngBytes();
                        if (bytes != null) {
                          context.read<DocumentBloc>().add(
                                UpdateSignedDocuments(
                                  documentId: widget.document.id,
                                  signedUrl: base64Encode(bytes),
                                ),
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Sign Document'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
