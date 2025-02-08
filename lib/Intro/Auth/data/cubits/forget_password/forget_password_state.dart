part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgotPasswordLoading extends ForgetPasswordState {}

class ForgotPasswordEmailSent extends ForgetPasswordState {
  final String email;
  final String message;

  ForgotPasswordEmailSent({required this.email, required this.message});
}

class ForgotPasswordSuccess extends ForgetPasswordState {
  final String message;

  ForgotPasswordSuccess({required this.message});
}

class ForgotPasswordError extends ForgetPasswordState {
  final String message;

  ForgotPasswordError({required this.message});
}
