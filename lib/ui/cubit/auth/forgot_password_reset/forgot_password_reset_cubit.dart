import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/forgot_password_reset/forgot_password_reset_entity.dart';
import '../../../../data/repository/auth/forgot_password_reset/forgot_password_reset_repository.dart';

part 'forgot_password_reset_state.dart';

class ForgotPasswordResetCubit extends Cubit<ForgotPasswordResetState> {
  final IForgotPasswordResetRepository _repository;

  ForgotPasswordResetCubit(this._repository) : super(ForgotPasswordResetInitial());

  Future<void> forgotPasswordReset(ForgotPasswordResetEntity entity) async {
    try {
      emit(ForgotPasswordResetLoading());

      await _repository.forgotPasswordReset(entity);
      emit(ForgotPasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordResetError(e.toString()));
    }
  }
}
