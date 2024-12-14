import 'dart:convert';

import 'package:esign/core/theme/app_colors.dart';
import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/bloc/profile/profile_state.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:esign/presentation/pages/home_page.dart';
import 'package:esign/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  final String userName;
  final String userEmail;

  const AppDrawer({Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<ProfileBloc>().add(LoadProfile(userId: authState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profilePicture =
            state is ProfileLoaded ? state.profile.profilePictureUrl : null;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                  ),
                  accountName: Text(
                    widget.userName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  accountEmail: Text(
                    widget.userEmail,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    backgroundImage: profilePicture != null
                        ? MemoryImage(
                            base64Decode(profilePicture.split(',')[1]))
                        : null,
                    child: profilePicture == null
                        ? Text(
                            widget.userName[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                            ),
                          )
                        : null,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Beranda'),
                  onTap: () {
                    Navigator.of(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profil'),
                  onTap: () {
                    Navigator.of(context);
                    final authState = context.read<AuthBloc>().state;
                    if (authState is AuthSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => getIt<ProfileBloc>()
                                ..add(LoadProfile(userId: authState.user.id)),
                              child: const ProfilePage(),
                            ),
                          ));
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
