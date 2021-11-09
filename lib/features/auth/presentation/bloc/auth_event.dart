part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  RegisterEvent(
      {required this.email, required this.password, required this.name});
}

class FetchUserEvent extends AuthEvent {}

class LogoutUserEvent extends AuthEvent {}

class ResetStateEvent extends AuthEvent {}
