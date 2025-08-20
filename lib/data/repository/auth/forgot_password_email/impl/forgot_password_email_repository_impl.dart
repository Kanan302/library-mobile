import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/auth/forgot_password_email/forgot_password_email_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/auth/forgot_password_email/forgot_password_email_entity.dart';
import '../../../../services/auth/auth_api_client.dart';
import '../forgot_password_email_repository.dart';

class ForgotPasswordEmailRepositoryImpl implements IForgotPasswordEmailRepository {
  final AuthApiClient _authService;

  ForgotPasswordEmailRepositoryImpl(this._authService);

  @override
  Future<void> forgotPasswordEmail(ForgotPasswordEmailEntity entity) async {
    try {
      final dto = entity.toDto();
      await _authService.forgotPasswordEmail(dto);
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final errorMessage = responseData?[AppKeys.message] ?? e.message ?? UiStrings.errorOccurred;

      showLog("General Dio exception: $errorMessage");
      throw CustomException(errorMessage);
    } catch (e, stackTrace) {
      showLog("General exception: $e\n$stackTrace");
      throw CustomException(UiStrings.errorOccurred);
    }
  }
}
