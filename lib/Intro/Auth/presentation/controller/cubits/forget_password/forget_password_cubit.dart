import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository _authRepository;

  ForgetPasswordCubit(this._authRepository) : super(ForgetPasswordInitial());

  Future<void> sendRecoveryEmail(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await _authRepository.requestPasswordReset(email);
      emit(ForgotPasswordEmailSent(email: email, message: response['message']));
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    
    }
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String newPasswordConfirmation,
    required String otp,
  }) async {
    try {
      final response = await _authRepository.resetPassword(
          email: email,
          newPassword: newPassword,
          newPasswordConfirmation: newPasswordConfirmation,
          otp: otp);
      emit(ForgotPasswordSuccess(message: response['message']));
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    }
  }
}
