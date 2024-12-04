import 'package:esign/presentation/widgets/auth/login_button.dart';
import 'package:esign/presentation/widgets/auth/password_toggle_icon.dart';
import 'package:esign/presentation/widgets/common/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CustomTextField(
            controller: emailController,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: passwordController,
            hint: "Password",
            obscureText: obscurePassword,
            suffixIcon: PasswordToggleIcon(
              obscurePassword: obscurePassword,
              onToggle: onTogglePassword,
            ),
          ),
          const SizedBox(height: 20),
          LoginButton(
            isLoading: isLoading,
            onPressed: onLogin,
          ),
        ],
      );
}
