import 'package:flutter/material.dart';

class AppDecoration {
  static BoxDecoration get inputShadow =>
      BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: -3,
          blurRadius: 3,
          offset: Offset(1, 8),
        )
      ]);

  static InputDecoration get input => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 127, 180, 244),
        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      );
}
