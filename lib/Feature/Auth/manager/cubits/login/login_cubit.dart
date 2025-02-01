import 'package:bloc/bloc.dart';
import 'package:cloozy/Feature/Auth/manager/models/login_model.dart';
import 'package:cloozy/Feature/Auth/manager/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(LoginInitial());
  final AuthRepository _repository;
  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await _repository.login(LoginRequest(
        email: email,
        password: password,
      ));
      emit(LoginSuccess(response.token));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
