import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/entity/category/get_categories/get_categories_entity.dart';
import '../../../../data/repository/category/get_categories/get_categories_repository.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final IGetCategoriesRepository _repository;

  GetCategoriesCubit(this._repository) : super(GetCategoriesInitial());

  Future<void> getCategories({bool forceRefresh = false}) async {
    try {
      emit(GetCategoriesLoading());

      final response = await _repository.getCategories();
      emit(GetCategoriesSuccess(response));
    } catch (e) {
      emit(GetCategoriesError(e.toString()));
    }
  }
}
