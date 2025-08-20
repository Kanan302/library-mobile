import '../../../dto/auth/forgot_password_otp/forgot_password_otp_dto.dart';
import '../../../entity/auth/forgot_password_otp/forgot_password_otp_entity.dart';

extension ForgotPasswordOtpMapper on ForgotPasswordOtpEntity {
  ForgotPasswordOtpDto toDto() {
    return ForgotPasswordOtpDto(otpCode: otpCode);
  }
}
