part of 'forgot_password_reset_cubit.dart';

abstract class ForgotPasswordResetState extends Equatable {
  const ForgotPasswordResetState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordResetInitial extends ForgotPasswordResetState {}

class ForgotPasswordResetLoading extends ForgotPasswordResetState {}

class ForgotPasswordResetSuccess extends ForgotPasswordResetState {}

class ForgotPasswordResetError extends ForgotPasswordResetState {
  final String errorMessage;

  const ForgotPasswordResetError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
