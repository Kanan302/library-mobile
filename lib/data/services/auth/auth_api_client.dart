import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../shared/constants/app_keys.dart';
import '../../dto/auth/forgot_password_email/forgot_password_email_dto.dart';
import '../../dto/auth/forgot_password_otp/forgot_password_otp_dto.dart';
import '../../dto/auth/forgot_password_reset/forgot_password_reset_dto.dart';
import '../../dto/auth/login/login_dto.dart';
import '../../dto/auth/register_otp/register_otp_dto.dart';
import '../../dto/auth/verify_register/verify_register_dto.dart';

part 'auth_api_client.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi(baseUrl: AppKeys.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST('/auth/login')
  Future<HttpResponse<void>> login(@Body() LoginDto dto);

  @POST('/auth/register/request-otp')
  Future<HttpResponse<void>> sendRegisterOtp(@Body() RegisterOtpDto dto);

  @POST('/auth/register/verify')
  Future<HttpResponse<void>> verifyRegister(@Body() VerifyRegisterDto dto);

  @POST('/auth/forgot-password/request-otp')
  Future<HttpResponse<void>> forgotPasswordEmail(@Body() ForgotPasswordEmailDto dto);

  @POST('/auth/forgot-password/verify-otp')
  Future<HttpResponse<void>> forgotPasswordOtp(@Body() ForgotPasswordOtpDto dto);

  @POST('/auth/forgot-password/reset')
  Future<HttpResponse<void>> forgotPasswordReset(@Body() ForgotPasswordResetDto dto);
}
