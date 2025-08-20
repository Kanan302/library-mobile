import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/verify_register/verify_register_entity.dart';
import '../../../../data/repository/auth/verify_register/verify_register_repository.dart';

part 'verify_register_state.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  final IVerifyRegisterRepository _repository;

  VerifyRegisterCubit(this._repository) : super(VerifyRegisterInitial());

  Future<void> verifyRegister(VerifyRegisterEntity entity) async {
    try {
      emit(VerifyRegisterLoading());

      await _repository.verifyRegister(entity);
      emit(VerifyRegisterSuccess());
    } catch (e) {
      emit(VerifyRegisterError(e.toString()));
    }
  }
}
