import 'package:dio/dio.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../services/author/author_api_client.dart';
import '../delete_author_repository.dart';

class DeleteAuthorRepositoryImpl implements IDeleteAuthorRepository {
  final AuthorApiClient _authorApiClient;

  DeleteAuthorRepositoryImpl(this._authorApiClient);

  @override
  Future<void> deleteAuthor(int id) async {
    try {
      await _authorApiClient.deleteAuthor(id);
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
