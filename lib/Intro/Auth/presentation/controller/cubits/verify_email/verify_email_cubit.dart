import 'package:bloc/bloc.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final AuthRepository authRepository;

  VerifyEmailCubit(this.authRepository) : super(VerifyEmailInitial());

  Future<void> sendOtp(String email) async {
    if (email.isEmpty) {
      emit(VerifyEmailError("Email is missing!"));
      return;
    }
    print('📩 Sending OTP to: $email');
    emit(VerifyEmailLoading());
    try {
      await authRepository.verifyEmail(email);
      emit(VerifyEmailSent());
    } catch (e) {
      emit(VerifyEmailError(e.toString()));
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(VerifyOtpLoading());
    try {
      final token = await authRepository.verifyEmailOtp(email, otp);
      emit(VerifyOtpSuccess(token));
    } catch (e) {
      emit(VerifyOtpError(e.toString()));
    }
  }
}
