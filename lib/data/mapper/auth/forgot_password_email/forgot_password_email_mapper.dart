import '../../../dto/auth/forgot_password_email/forgot_password_email_dto.dart';
import '../../../entity/auth/forgot_password_email/forgot_password_email_entity.dart';

extension ForgotPasswordEmailMapper on ForgotPasswordEmailEntity {
  ForgotPasswordEmailDto toDto() {
    return ForgotPasswordEmailDto(email: email);
  }
}
