import 'package:esign/core/routes/routes_name.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:esign/presentation/pages/auth/register_page.dart';
import 'package:esign/presentation/widgets/auth/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
    if (state is AuthSuccess) {
      Navigator.pushReplacementNamed(context, RouteName.home);
    }
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Semua field harus diisi!')));
      return;
    }

    context.read<AuthBloc>().add(
          LoginEvent(_emailController.text, _passwordController.text),
        );
  }

  @override
  Widget build(BuildContext context) => BaseLayout(
        showAppBar: false,
        showBackButton: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: _handleAuthState,
          builder: (context, state) => SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  LoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    obscurePassword: _obscurePassword,
                    onTogglePassword: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    isLoading: _isLoading,
                    onLogin: _handleLogin,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text('Lupa Password?'),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Belum punya akun? ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Daftar di sini',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
