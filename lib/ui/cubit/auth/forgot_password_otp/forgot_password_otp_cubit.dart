import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/forgot_password_otp/forgot_password_otp_entity.dart';
import '../../../../data/repository/auth/forgot_password_otp/forgot_password_otp_repository.dart';

part 'forgot_password_otp_state.dart';

class ForgotPasswordOtpCubit extends Cubit<ForgotPasswordOtpState> {
  final IForgotPasswordOtpRepository _repository;

  ForgotPasswordOtpCubit(this._repository) : super(ForgotPasswordOtpInitial());

  Future<void> forgotPasswordOtp(ForgotPasswordOtpEntity entity) async {
    try {
      emit(ForgotPasswordOtpLoading());

      await _repository.forgotPasswordOtp(entity);
      emit(ForgotPasswordOtpSuccess());
    } catch (e) {
      emit(ForgotPasswordOtpError(e.toString()));
    }
  }
}
