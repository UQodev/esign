import 'package:esign/core/theme/app_colors.dart';
import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:esign/presentation/pages/home_page.dart';
import 'package:esign/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const AppDrawer({Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                userName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              accountEmail: Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userName[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
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
  }
}
