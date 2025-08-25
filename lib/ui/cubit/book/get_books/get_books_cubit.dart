import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/book/get_books/get_books_entity.dart';
import '../../../../data/repository/book/get_books/get_books_repository.dart';

part 'get_books_state.dart';

class GetBooksCubit extends Cubit<GetBooksState> {
  final IGetBooksRepository _repository;

  GetBooksCubit(this._repository) : super(GetBooksInitial());

  Future<void> getBooks({bool forceRefresh = false}) async {
    try {
      emit(GetBooksLoading());

      final response = await _repository.getBooks();
      emit(GetBooksSuccess(response));
    } catch (e) {
      emit(GetBooksError(e.toString()));
    }
  }
}
