import 'package:esign/core/routes/routes_name.dart';
import 'package:esign/presentation/pages/auth/verify_email_page.dart';
import 'package:esign/presentation/widgets/auth/auth_button.dart';
import 'package:esign/presentation/widgets/auth/password_toggle_icon.dart';
import 'package:esign/presentation/widgets/common/custom_field.dart';
import 'package:esign/presentation/widgets/custom_page_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  final bool isRegister;
  final TextEditingController? fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final bool isLoading;
  final VoidCallback onSubmit;
  final FocusNode? fullNameFocus;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final VoidCallback onNavigate;

  const AuthForm({
    Key? key,
    this.isRegister = false,
    this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onSubmit,
    this.fullNameFocus,
    required this.emailFocus,
    required this.passwordFocus,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isRegister
                  ? "Buat Akun Baru🚀"
                  : "Selamat Datang Kembali👋",
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // const SizedBox(height: 5),
            Text(
              widget.isRegister
                  ? "Masukkan detail Anda di bawah untuk membuat akun dan memulai"
                  : "Untuk tetap terhubung dengan kami silakan login dengan informasi pribadi Anda",
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Color(0XFFAFAFB1),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (widget.isRegister) ...[
              Text(
                'Nama Lengkap',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFFAFAFB1),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                controller: widget.fullNameController!,
                focusNode: widget.fullNameFocus,
                hint: 'Masukkan Nama Lengkap Anda',
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(
                  Icons.person_outline,
                  color: Colors.black,
                ),
              ),
            ],
            const SizedBox(height: 15),
            Text(
              'Email',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFAFAFB1),
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: widget.emailController,
              focusNode: widget.emailFocus,
              hint: 'Masukkan Email Anda',
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Password',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFAFAFB1),
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              controller: widget.passwordController,
              hint: "Masukkan Password Anda",
              obscureText: widget.obscurePassword,
              suffixIcon: PasswordToggleIcon(
                obscurePassword: widget.obscurePassword,
                onToggle: widget.onTogglePassword,
              ),
            ),
            const SizedBox(height: 10),
            if (!widget.isRegister) ...[
              // const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                          child: const VerifyEmailPage(),
                          settings:
                              const RouteSettings(name: RouteName.verifyEmail),
                        ));
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Text(
                    "Lupa Password?",
                    style: GoogleFonts.lexend(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color(0XFF3391CD),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 140),
            if (widget.isRegister) ...[
              Container(
                // color: Colors.black,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, -12),
                            child: Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Dengan mengklik Daftar, Anda menyetujui ",
                                    style: GoogleFonts.lexend(
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Syarat & Ketentuan",
                                    style: GoogleFonts.lexend(
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => const PrivacyPolicyPage(),
                                        //   ),
                                        // );
                                      },
                                  ),
                                  TextSpan(
                                    text: " dan ",
                                    style: GoogleFonts.lexend(
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Kebijakan Privasi",
                                    style: GoogleFonts.lexend(
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => const PrivacyPolicyPage(),
                                        //   ),
                                        // );
                                      },
                                  ),
                                  TextSpan(
                                    text: " DocuMark",
                                    style: GoogleFonts.lexend(
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            AuthButton(
              isLoading: widget.isLoading,
              onPressed:
                  (!widget.isRegister || _isChecked) ? widget.onSubmit : null,
              buttonText: widget.isRegister ? "Daftar" : "Masuk",
              isEnabled: !widget.isRegister || _isChecked,
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: widget.isRegister
                        ? "Sudah punya akun? "
                        : "Belum punya akun? ",
                    style: GoogleFonts.lexend(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    )),
                  ),
                  TextSpan(
                      text: widget.isRegister
                          ? "Masuk di sini"
                          : "Daftar di sini",
                      style: GoogleFonts.lexend(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onNavigate),
                ]),
              ),
            ),
            // const SizedBox(height: 30),
          ],
        ),
      );
}
