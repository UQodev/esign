import 'package:esign/core/theme/app_decoration.dart';
import 'package:esign/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? enabled;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.hint,
      this.obscureText = false,
      this.suffixIcon,
      this.keyboardType,
      this.focusNode,
      this.enabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.inputShadow,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTextStyles.input,
        decoration: AppDecoration.customInput(
          hint: hint ?? '',
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? hint;
  final Widget? suffixIcon;
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    Key? key,
    this.hint,
    this.suffixIcon,
    this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.inputShadow,
      child: DropdownButtonFormField<String>(
        decoration: AppDecoration.customInput(
          hint: hint ?? '',
          suffixIcon: suffixIcon,
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        style: AppTextStyles.input,
      ),
    );
  }
}
