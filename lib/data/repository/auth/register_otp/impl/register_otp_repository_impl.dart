import 'package:dio/dio.dart';

import 'package:library_app/data/mapper/auth/register_otp/register_otp_mapper.dart';

import '../../../../../shared/constants/app_keys.dart';
import '../../../../../shared/utils/exception.dart';
import '../../../../../shared/utils/logger.dart';
import '../../../../../ui/shared/constants/ui_strings.dart';
import '../../../../entity/auth/register_otp/register_otp_entity.dart';
import '../../../../services/auth/auth_api_client.dart';
import '../register_otp_repository.dart';

class RegisterOtpRepositoryImpl implements IRegisterOtpRepository {
  final AuthApiClient _authService;

  RegisterOtpRepositoryImpl(this._authService);

  @override
  Future<void> sendRegisterOtp(RegisterOtpEntity entity) async {
    try {
      final dto = entity.toDto();
      await _authService.sendRegisterOtp(dto);
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
