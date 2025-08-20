import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/auth/register_otp/register_otp_entity.dart';
import '../../../../data/repository/auth/register_otp/register_otp_repository.dart';

part 'register_otp_state.dart';

class RegisterOtpCubit extends Cubit<RegisterOtpState> {
  final IRegisterOtpRepository _repository;

  RegisterOtpCubit(this._repository) : super(RegisterOtpInitial());

  Future<void> sendRegisterOtp(RegisterOtpEntity entity) async {
    try {
      emit(RegisterOtpLoading());

      await _repository.sendRegisterOtp(entity);
      emit(RegisterOtpSuccess());
    } catch (e) {
      emit(RegisterOtpError(e.toString()));
    }
  }
}
