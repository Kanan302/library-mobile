part of 'forgot_password_email_cubit.dart';

abstract class ForgotPasswordEmailState extends Equatable {
  const ForgotPasswordEmailState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordEmailInitial extends ForgotPasswordEmailState {}

class ForgotPasswordEmailLoading extends ForgotPasswordEmailState {}

class ForgotPasswordEmailSuccess extends ForgotPasswordEmailState {}

class ForgotPasswordEmailError extends ForgotPasswordEmailState {
  final String errorMessage;

  const ForgotPasswordEmailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
