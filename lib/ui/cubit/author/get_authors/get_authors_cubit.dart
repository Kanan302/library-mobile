import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/author/get_authors/get_authors_entity.dart';
import '../../../../data/repository/author/get_authors/get_authors_repository.dart';

part 'get_authors_state.dart';

class GetAuthorsCubit extends Cubit<GetAuthorsState> {
  final IGetAuthorsRepository _repository;

  GetAuthorsCubit(this._repository) : super(GetAuthorsInitial());

  Future<void> getAuthors({bool forceRefresh = false}) async {
    try {
      emit(GetAuthorsLoading());

      final response = await _repository.getAuthors();
      emit(GetAuthorsSuccess(response));
    } catch (e) {
      emit(GetAuthorsError(e.toString()));
    }
  }
}
