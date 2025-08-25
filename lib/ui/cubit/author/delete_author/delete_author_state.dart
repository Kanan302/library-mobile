part of 'delete_author_cubit.dart';

abstract class DeleteAuthorState extends Equatable {
  const DeleteAuthorState();

  @override
  List<Object?> get props => [];
}

class DeleteAuthorInitial extends DeleteAuthorState {}

class DeleteAuthorLoading extends DeleteAuthorState {}

class DeleteAuthorSuccess extends DeleteAuthorState {}

class DeleteAuthorError extends DeleteAuthorState {
  final String errorMessage;

  const DeleteAuthorError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
