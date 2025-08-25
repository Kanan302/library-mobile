import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../shared/constants/app_keys.dart';
import '../../../shared/services/config/base_response_dto.dart';
import '../../dto/book/get_books/get_books_dto.dart';

part 'book_api_client.g.dart';

@RestApi(baseUrl: AppKeys.baseUrl)
abstract class BookApiClient {
  factory BookApiClient(Dio dio, {String baseUrl}) = _BookApiClient;

  @GET('/books')
  Future<HttpResponse<BaseResponseDto<List<GetBookDto>>>> getBooks();
}
