part of 'forgot_password_otp_cubit.dart';

abstract class ForgotPasswordOtpState extends Equatable {
  const ForgotPasswordOtpState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpInitial extends ForgotPasswordOtpState {}

class ForgotPasswordOtpLoading extends ForgotPasswordOtpState {}

class ForgotPasswordOtpSuccess extends ForgotPasswordOtpState {}

class ForgotPasswordOtpError extends ForgotPasswordOtpState {
  final String errorMessage;

  const ForgotPasswordOtpError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
