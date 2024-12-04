import 'package:flutter/material.dart';

class PasswordToggleIcon extends StatelessWidget {
  final bool obscurePassword;
  final VoidCallback onToggle;

  const PasswordToggleIcon({
    Key? key,
    required this.obscurePassword,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(
          obscurePassword ? Icons.visibility : Icons.visibility,
          color: Colors.black54,
        ),
        onPressed: onToggle,
      );
}
