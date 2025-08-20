import '../../../entity/auth/forgot_password_email/forgot_password_email_entity.dart';

abstract class IForgotPasswordEmailRepository {
  Future<void> forgotPasswordEmail(ForgotPasswordEmailEntity entity);
}
