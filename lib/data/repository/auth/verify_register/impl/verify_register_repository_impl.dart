import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/auth/verify_register/verify_register_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/auth/verify_register/verify_register_entity.dart';
import '../../../../services/auth/auth_api_client.dart';
import '../verify_register_repository.dart';

class VerifyRegisterRepositoryImpl implements IVerifyRegisterRepository {
  final AuthApiClient _authService;

  VerifyRegisterRepositoryImpl(this._authService);

  @override
  Future<void> verifyRegister(VerifyRegisterEntity entity) async {
    try {
      final dto = entity.toDto();
      await _authService.verifyRegister(dto);
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
