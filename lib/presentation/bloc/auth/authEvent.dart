import 'package:flutter/material.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterEvent(this.name, this.email, this.password);
}

class LogoutEvent extends AuthEvent {
  final BuildContext context;
  LogoutEvent(this.context);
}

class CheckAuthEvent extends AuthEvent {}
