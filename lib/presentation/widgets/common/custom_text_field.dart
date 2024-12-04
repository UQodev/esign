import 'package:esign/presentation/styles/app_decoration.dart';
import 'package:esign/presentation/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: AppDecoration.inputShadow,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyles.input,
          decoration: AppDecoration.input.copyWith(
            hintText: hint,
            suffixIcon: suffixIcon,
          ),
        ),
      );
}
