import '../../../entity/auth/forgot_password_reset/forgot_password_reset_entity.dart';

abstract class IForgotPasswordResetRepository {
  Future<void> forgotPasswordReset(ForgotPasswordResetEntity entity);
}
