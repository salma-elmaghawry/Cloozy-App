part of 'verify_email_cubit.dart';

@immutable
sealed class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSent extends VerifyEmailState {}

class VerifyEmailError extends VerifyEmailState {
  final String message;
  VerifyEmailError(this.message);
}

class VerifyOtpLoading extends VerifyEmailState {}

class VerifyOtpSuccess extends VerifyEmailState {
  final String token;
  VerifyOtpSuccess(this.token);
}

class VerifyOtpError extends VerifyEmailState {
  final String message;
  VerifyOtpError(this.message);
}
