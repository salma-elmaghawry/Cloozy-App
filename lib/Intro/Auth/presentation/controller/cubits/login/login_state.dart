part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final bool isEmailVerified;
  LoginSuccess(this.token,this.isEmailVerified);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
