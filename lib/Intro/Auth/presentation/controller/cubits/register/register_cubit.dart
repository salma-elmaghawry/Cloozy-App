import 'package:cloozy/Intro/Auth/data/models/register_model.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _repository;
  RegisterCubit(this._repository) : super(RegisterInitial());

  Future<void> registerUser(RegisterRequest request) async {
    emit(RegisterLoading());
    try {
      final response = await _repository.register(request);
      emit(RegisterSuccess(response.message ));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
