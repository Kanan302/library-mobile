part of 'register_otp_cubit.dart';

abstract class RegisterOtpState extends Equatable {
  const RegisterOtpState();

  @override
  List<Object?> get props => [];
}

class RegisterOtpInitial extends RegisterOtpState {}

class RegisterOtpLoading extends RegisterOtpState {}

class RegisterOtpSuccess extends RegisterOtpState {}

class RegisterOtpError extends RegisterOtpState {
  final String errorMessage;

  const RegisterOtpError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
