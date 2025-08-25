import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../shared/constants/app_keys.dart';
import '../../../shared/services/config/base_response_dto.dart';
import '../../dto/category/get_categories/get_categories_dto.dart';

part 'category_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class CategoryApiClient {
  factory CategoryApiClient(Dio dio, {String baseUrl}) = _CategoryApiClient;

  @GET('/category')
  Future<HttpResponse<BaseResponseDto<List<GetCategoryDto>>>> getCategories();
}
