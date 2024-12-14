import 'dart:convert';
import 'dart:typed_data';

import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/bloc/profile/profile_state.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:esign/presentation/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>(),
      child: const ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({super.key});

  @override
  State<ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final SignatureController _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white);
  DateTime? _selectedDate;
  String? _profilePictureUrl;
  bool _isEditing = false;
  bool _tempCleared = false; // Add this for temporary clear state
  bool _isLoading = true; // Add this for temporary clear state

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<ProfileBloc>().add(LoadProfile(userId: authState.user.id));
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 100,
    );
    if (image != null) {
      try {
        setState(() {
          _isLoading = true;
        });
        final bytes = await image.readAsBytes();
        final base64Image = 'data:image/png;base64,${base64Encode(bytes)}';

        setState(() {
          _profilePictureUrl = base64Image;
          _isLoading = false;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to pick image: $e')),
          );
        }
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveProfile() async {
    if (!_isEditing) return;

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      // Get signature bytes if changed
      Uint8List? signatureBytes;
      if (_signatureController.isNotEmpty) {
        signatureBytes = await _signatureController.toPngBytes();
      }

      // Save both profile and signature
      context.read<ProfileBloc>().add(
            UpdateProfileAndSignature(
              userId: authState.user.id,
              fullName: _fullNameController.text.isNotEmpty
                  ? _fullNameController.text
                  : null,
              birthDate: _selectedDate,
              phoneNumber: _phoneNumberController.text.isNotEmpty
                  ? _phoneNumberController.text
                  : null,
              profilePictureUrl: _profilePictureUrl,
              signatureBytes: signatureBytes,
            ),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saving profile...')),
        );
      }

      setState(() => _isEditing = false);
    }
  }

  Future<void> _saveSignature() async {
    print('Saving signature...');

    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw your signature')),
      );
      return;
    }
    ;

    final bytes = await _signatureController.toPngBytes();
    if (bytes != null) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthSuccess) {
        print('Uploading signature...');
        context.read<ProfileBloc>().add(
              UpdateSignature(userId: authState.user.id, signatureBytes: bytes),
            );
      }
    }
  }

  Widget _buildSignatureSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Your Signature',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded &&
                  state.signature?.signatureUrl != null) {
                final base64Data = state.signature!.signatureUrl!.split(',')[1];

                // If editing and not cleared - show original signature
                if (_isEditing && !_tempCleared) {
                  return Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.white,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  );
                }

                // If editing and cleared - show empty canvas
                if (_isEditing && _tempCleared) {
                  return Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.white,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  );
                }

                // Not editing - show existing signature
                return Center(
                  child: Image.memory(
                    base64Decode(base64Data),
                    fit: BoxFit.contain,
                  ),
                );
              }

              // No existing signature - show empty canvas
              return Signature(
                controller: _signatureController,
                backgroundColor: Colors.white,
                height: 200,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
        ),
        if (_isEditing) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _tempCleared = true;
                    _signatureController.clear();
                  });
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear'),
              ),
            ),
          ),
        ]
      ],
    );
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _tempCleared = false;
      _signatureController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showAppBar: true,
      title: 'Profile',
      drawer: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return AppDrawer(
              userName: state.user.name,
              userEmail: state.user.email,
            );
          }
          return const SizedBox(); // Fallback empty widget
        },
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProfileLoaded) {
            setState(() {
              _fullNameController.text = state.profile.fullName ?? '';
              _selectedDate = state.profile.birthDate;
              _phoneNumberController.text = state.profile.phoneNumber ?? '';
              _profilePictureUrl = state.profile.profilePictureUrl;
            });

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Berhasil mengupdate profile')));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _isEditing ? _pickImage : null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilePictureUrl != null
                            ? MemoryImage(
                                base64Decode(_profilePictureUrl!.split(',')[1]))
                            : null,
                        child: _profilePictureUrl == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.grey)
                            : null,
                      ),
                      if (_isEditing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Profile Form
                TextField(
                  controller: _fullNameController,
                  enabled: _isEditing,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Birth Date
                InkWell(
                  onTap: _isEditing ? _selectDate : null,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Birth Date',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                          : 'Select Date',
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Phone Number
                TextField(
                  controller: _phoneNumberController,
                  enabled: _isEditing,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                _buildSignatureSection(context),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!_isEditing)
                      ElevatedButton.icon(
                        onPressed: () => setState(() => _isEditing = true),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      )
                    else ...[
                      ElevatedButton.icon(
                        onPressed: () => setState(() => _isEditing = false),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _saveProfile,
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
