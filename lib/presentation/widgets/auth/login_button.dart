import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  Widget build(BuildContext context) => MaterialButton(
        onPressed: isLoading ? null : onPressed,
        color: const Color(0xFF0077C0),
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
        textColor: Colors.white,
        height: 40,
        minWidth: MediaQuery.of(context).size.width,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
      );
}
