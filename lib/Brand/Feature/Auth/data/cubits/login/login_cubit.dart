import 'package:bloc/bloc.dart';
import 'package:cloozy/Brand/Feature/Auth/data/models/login_model.dart';
import 'package:cloozy/Brand/Feature/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Brand/Feature/Auth/data/services/secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      emit(LoginSuccess(response.token));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('token');

    if (storedToken != null && storedToken.isNotEmpty) {
      emit(LoginSuccess(storedToken));
    }
  }
Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); 
    await SecureStorage.deleteToken(); 
    emit(LoginInitial());
  }


}
   //check Check for stored token and login automatically (remember me was true)
