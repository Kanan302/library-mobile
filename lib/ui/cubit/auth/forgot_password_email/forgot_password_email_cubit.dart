import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/forgot_password_email/forgot_password_email_entity.dart';
import '../../../../data/repository/auth/forgot_password_email/forgot_password_email_repository.dart';

part 'forgot_password_email_state.dart';

class ForgotPasswordEmailCubit extends Cubit<ForgotPasswordEmailState> {
  final IForgotPasswordEmailRepository _repository;

  ForgotPasswordEmailCubit(this._repository) : super(ForgotPasswordEmailInitial());

  Future<void> forgotPasswordEmail(ForgotPasswordEmailEntity entity) async {
    try {
      emit(ForgotPasswordEmailLoading());

      await _repository.forgotPasswordEmail(entity);
      emit(ForgotPasswordEmailSuccess());
    } catch (e) {
      emit(ForgotPasswordEmailError(e.toString()));
    }
  }
}
