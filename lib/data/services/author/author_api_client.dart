import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../shared/constants/app_keys.dart';
import '../../../shared/services/config/base_response_dto.dart';
import '../../dto/author/get_authors/get_authors_dto.dart';

part 'author_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class AuthorApiClient {
  factory AuthorApiClient(Dio dio, {String baseUrl}) = _AuthorApiClient;

  @GET('/author')
  Future<HttpResponse<BaseResponseDto<List<GetAuthorsDto>>>> getAuthors();

  @DELETE('/author/{id}/delete')
  Future<HttpResponse<BaseResponseDto<void>>> deleteAuthor(@Path('id') int id);
}
