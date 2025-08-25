part of 'get_books_cubit.dart';

abstract class GetBooksState extends Equatable {
  const GetBooksState();

  @override
  List<Object?> get props => [];
}

class GetBooksInitial extends GetBooksState {}

class GetBooksLoading extends GetBooksState {}

class GetBooksSuccess extends GetBooksState {
  final List<GetBookEntity> response;

  const GetBooksSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetBooksError extends GetBooksState {
  final String errorMessage;

  const GetBooksError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
