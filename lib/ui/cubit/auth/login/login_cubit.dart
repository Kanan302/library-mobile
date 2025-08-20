import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/login/login_entity.dart';
import '../../../../data/repository/auth/login/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ILoginRepository _repository;

  LoginCubit(this._repository) : super(LoginInitial());

  Future<void> login(LoginEntity entity) async {
    try {
      emit(LoginLoading());

      await _repository.login(entity);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
