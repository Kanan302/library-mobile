import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/category/get_categories/get_categories_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/category/get_categories/get_categories_entity.dart';
import '../../../../services/category/category_api_client.dart';
import '../get_categories_repository.dart';

class GetCategoriesRepositoryImpl implements IGetCategoriesRepository {
  final CategoryApiClient _categoryApiClient;

  GetCategoriesRepositoryImpl(this._categoryApiClient);

  @override
  Future<List<GetCategoryEntity>> getCategories() async {
    try {
      final response = await _categoryApiClient.getCategories();
      final base = response.data;

      final entityList = base.data.map((dto) => dto.toEntity()).toList();

      return entityList;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      showLog("Dio error data: $responseData");
      final errorMessage = responseData?[AppKeys.message] ?? e.message ?? UiStrings.errorOccurred;

      showLog("General Dio exception: $errorMessage");
      throw CustomException(errorMessage);
    } catch (e, stackTrace) {
      showLog("General exception: $e\n$stackTrace");
      throw CustomException(UiStrings.errorOccurred);
    }
  }
}
