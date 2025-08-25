part of 'get_authors_cubit.dart';

abstract class GetAuthorsState extends Equatable {
  const GetAuthorsState();

  @override
  List<Object?> get props => [];
}

class GetAuthorsInitial extends GetAuthorsState {}

class GetAuthorsLoading extends GetAuthorsState {}

class GetAuthorsSuccess extends GetAuthorsState {
  final List<GetAuthorsEntity> response;

  const GetAuthorsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetAuthorsError extends GetAuthorsState {
  final String errorMessage;

  const GetAuthorsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
