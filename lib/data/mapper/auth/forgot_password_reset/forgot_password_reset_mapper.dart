import '../../../dto/auth/forgot_password_reset/forgot_password_reset_dto.dart';
import '../../../entity/auth/forgot_password_reset/forgot_password_reset_entity.dart';

extension ForgotPasswordResetMapper on ForgotPasswordResetEntity {
  ForgotPasswordResetDto toDto() {
    return ForgotPasswordResetDto(newPassword: newPassword);
  }
}
