import '../../../dto/auth/register_otp/register_otp_dto.dart';
import '../../../entity/auth/register_otp/register_otp_entity.dart';

extension RegisterOtpEntityMapper on RegisterOtpEntity {
  RegisterOtpDto toDto() {
    return RegisterOtpDto(email: email, password: password);
  }
}
