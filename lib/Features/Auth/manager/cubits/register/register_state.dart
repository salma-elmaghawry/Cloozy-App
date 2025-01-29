part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponse response;
  RegisterSuccess(this.response);
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
