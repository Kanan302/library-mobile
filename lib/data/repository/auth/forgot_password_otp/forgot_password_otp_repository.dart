import '../../../entity/auth/forgot_password_otp/forgot_password_otp_entity.dart';

abstract class IForgotPasswordOtpRepository {
  Future<void> forgotPasswordOtp(ForgotPasswordOtpEntity entity);
}
