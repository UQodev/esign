import 'package:esign/presentation/bloc/auth/authBloc.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                  child: const Text('Logout')),
            )
          ],
        ),
      ),
    );
  }
}
