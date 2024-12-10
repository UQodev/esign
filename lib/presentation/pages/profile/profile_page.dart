import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/bloc/profile/profile_state.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  DateTime? _selectedDate;
  String? _profilePictureUrl;
  bool _isEditing = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // TODO: Upload image and get URL
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

  void _saveProfile() {
    if (!_isEditing) return;

    context.read<ProfileBloc>().add(
          UpdateProfile(
            userId: 'current_user_id', // Get from AuthBloc
            fullName: _fullNameController.text,
            birthDate: _selectedDate,
            phoneNumber: _phoneNumberController.text,
            profilePictureUrl: _profilePictureUrl,
          ),
        );

    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      showAppBar: true,
      title: 'Profile',
      body: BlocConsumer(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
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
                // Profile Picture
                GestureDetector(
                  onTap: _isEditing ? _pickImage : null,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilePictureUrl != null
                            ? NetworkImage(_profilePictureUrl!)
                            : null,
                        child: _profilePictureUrl == null
                            ? const Icon(Icons.person, size: 50)
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

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!_isEditing)
                      ElevatedButton.icon(
                        onPressed: () => setState(() => _isEditing = true),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
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
