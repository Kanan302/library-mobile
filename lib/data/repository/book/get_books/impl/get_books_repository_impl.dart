import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/book/get_books/get_books_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/book/get_books/get_books_entity.dart';
import '../../../../services/book/book_api_client.dart';
import '../get_books_repository.dart';

class GetBooksRepositoryImpl implements IGetBooksRepository {
  final BookApiClient _bookApiClient;

  GetBooksRepositoryImpl(this._bookApiClient);

  @override
  Future<List<GetBookEntity>> getBooks() async {
    try {
      final response = await _bookApiClient.getBooks();
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
