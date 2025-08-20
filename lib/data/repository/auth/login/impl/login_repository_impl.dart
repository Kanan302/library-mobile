import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/auth/login/login_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/services/local/secure_service.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/auth/login/login_entity.dart';
import '../../../../services/auth/auth_api_client.dart';
import '../login_repository.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final AuthApiClient _authService;
  final ISecureService _secureService;

  LoginRepositoryImpl(this._authService, this._secureService);

  @override
  Future<void> login(LoginEntity entity) async {
    try {
      final dto = entity.toDto();
      final httpResponse = await _authService.login(dto);

      final responseData = httpResponse.response.data;

      final accessToken = responseData[AppKeys.data]?[AppKeys.accessToken];
      final refreshToken = responseData[AppKeys.data]?[AppKeys.refreshToken];

      if (accessToken != null && refreshToken != null) {
        await _secureService.saveAccessToken(accessToken);
        await _secureService.saveRefreshToken(refreshToken);

        final savedAccess = await _secureService.getAccessToken;
        final savedRefresh = await _secureService.getRefreshToken;

        showLog("Saved access: $savedAccess");
        showLog("Saved refresh: $savedRefresh");
      } else {
        throw CustomException("Access və ya Refresh token tapılmadı.");
      }
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
