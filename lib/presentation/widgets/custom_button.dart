import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backGroundColor;
  final Color? textColor;
  final bool isOutlined;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backGroundColor,
    this.textColor,
    this.isOutlined = false,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50,
        decoration: BoxDecoration(
          gradient: !isOutlined
              ? const LinearGradient(
                  colors: [
                    Color(0xff3391CD),
                    Color(0XFF00b4d8),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(15),
          border: isOutlined
              ? Border.all(
                  color: const Color(0xff3391CD),
                  width: 2,
                )
              : null,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isOutlined ? const Color(0xff3391CD) : Colors.white,
            ),
          ),
        ),
      );
}
