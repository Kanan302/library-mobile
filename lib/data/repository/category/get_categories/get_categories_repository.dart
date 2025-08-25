import '../../../entity/category/get_categories/get_categories_entity.dart';

abstract class IGetCategoriesRepository {
  Future<List<GetCategoryEntity>> getCategories();
}
