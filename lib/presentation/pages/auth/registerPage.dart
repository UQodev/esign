import 'package:esign/presentation/pages/auth/loginPage.dart';
import 'package:esign/presentation/pages/auth/registerOption.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 236, 255),
      body: SafeArea(
        child: Container(
          // color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Registerasi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                  'Halo! Selamat Datang, Silahkan login terlebih dahulu :)'),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: -3,
                      blurRadius: 3,
                      offset: const Offset(1, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: TextEditingController(),
                  obscureText: false,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 127, 180, 244),
                    isDense: false,
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: -3,
                      blurRadius: 3,
                      offset: const Offset(1, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: TextEditingController(),
                  obscureText: false,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 127, 180, 244),
                    isDense: false,
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: -3,
                      blurRadius: 3,
                      offset: const Offset(1, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: TextEditingController(),
                  obscureText: false,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Color(0x00000000), width: 1),
                    ),
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 127, 180, 244),
                    isDense: false,
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lupa Password?',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterOption(),
                    ),
                  );
                },
                color: const Color.fromARGB(255, 39, 90, 179),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(10),
                textColor: Colors.white,
                height: 40,
                minWidth: MediaQuery.of(context).size.width,
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Sudah punya akun? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Login di sini',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
