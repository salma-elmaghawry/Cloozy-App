import 'package:bloc/bloc.dart';
import 'package:cloozy/Intro/Auth/data/models/login_model.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Intro/Auth/data/secure_storage.dart';
import 'package:meta/meta.dart';

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
       await SecureStorage.saveToken(response.token);
      emit(LoginSuccess(response.token,response.isEmailVerified));
    } catch (e) {
      emit(LoginError(e.toString()));
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
