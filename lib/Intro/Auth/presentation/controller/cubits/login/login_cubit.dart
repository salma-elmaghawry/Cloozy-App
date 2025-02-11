import 'package:cloozy/Intro/Auth/data/models/login_model.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Core/helper/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(LoginInitial());
  final AuthRepository _repository;
  Future<void> loginUser(String email, String password, bool remember) async {
    emit(LoginLoading());
    try {
      final response = await _repository.login(LoginRequest(
        email: email,
        password: password,
        remember: remember,
      ));
       if (response.token.isEmpty) {
      throw Exception('Received empty authentication token');
    }
       await SecureStorage.saveToken(response.token);
      emit(LoginSuccess(response.token,response.isEmailVerified));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
  Future<void> checkAutoLogin() async {
  emit(LoginLoading());
  try {
    if (await SecureStorage.isValidToken()) {
      final token = await SecureStorage.getToken();
      if (token != null && token.isNotEmpty) {
        emit(LoginSuccess(token, true)); // Assume email is verified
        return;
      }
    }
    emit(LoginInitial());
  } catch (e) {
    emit(LoginError('Session expired. Please login again'));
  }
}
  // Future<void> checkAutoLogin() async {
  //   emit(LoginLoading());
  //   try {
  //     final token = await SecureStorage.getToken();
  //     if (token != null) {
  //       emit(LoginSuccess(token));
  //     } else {
  //       emit(LoginInitial());
  //     }
  //   } catch (e) {
  //     emit(LoginInitial());
  //   }
  // }
// Future<void> logout() async {
   
//     await SecureStorage.deleteToken(); 
//     emit(LoginInitial());
//   }


}
   //check Check for stored token and login automatically (remember me was true)
// Future<void> logout() async {
//   await SecureStorage.deleteToken();
//   await SecureStorage.deleteTokenExpiry();
//   emit(LoginInitial());
// }