part of 'auth_bloc.dart';

abstract class AuthState {}

class EmptyAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ReadyAuthState extends AuthState {
  final UserEntity user;

  ReadyAuthState({required this.user});
}

class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState({required this.errorMessage});
}
