import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart' as app_state;
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:esign/presentation/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, app_state.AuthState>(
      builder: (context, state) {
        if (state is app_state.AuthSuccess) {
          return BaseLayout(
            showAppBar: true,
            title: 'E-Sign',
            drawer: AppDrawer(
              userName: state.user.name,
              userEmail: state.user.email,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        child: const Text('Logout')),
                  ),
                ],
              ),
            ),
          );
        }
        // Fallback jika tidak ada user
        return const BaseLayout(
          showAppBar: true,
          title: 'E-Sign',
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
