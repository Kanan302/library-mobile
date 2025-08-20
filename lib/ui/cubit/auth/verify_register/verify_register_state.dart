part of 'verify_register_cubit.dart';

abstract class VerifyRegisterState extends Equatable {
  const VerifyRegisterState();

  @override
  List<Object?> get props => [];
}

class VerifyRegisterInitial extends VerifyRegisterState {}

class VerifyRegisterLoading extends VerifyRegisterState {}

class VerifyRegisterSuccess extends VerifyRegisterState {}

class VerifyRegisterError extends VerifyRegisterState {
  final String errorMessage;

  const VerifyRegisterError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
