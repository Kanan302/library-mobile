import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/author/delete_author/delete_author_repository.dart';

part 'delete_author_state.dart';

class DeleteAuthorCubit extends Cubit<DeleteAuthorState> {
  final IDeleteAuthorRepository _repository;

  DeleteAuthorCubit(this._repository) : super(DeleteAuthorInitial());

  Future<void> deleteAuthor(int id) async {
    try {
      emit(DeleteAuthorLoading());

      await _repository.deleteAuthor(id);
    } catch (e) {
      emit(DeleteAuthorError(e.toString()));
    }
  }
}
