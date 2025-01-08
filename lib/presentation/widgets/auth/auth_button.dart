import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isEnabled;

  const AuthButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.buttonText,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnabled
                ? const [
                    Color(0xff3391CD),
                    Color(0XFF00b4d8),
                  ]
                : [
                    Colors.grey.shade300,
                    Colors.grey.shade400,
                  ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: MaterialButton(
          onPressed: isEnabled ? onPressed : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          textColor: Colors.white,
          height: 50,
          minWidth: MediaQuery.of(context).size.width,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  buttonText,
                  style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
      );
}
