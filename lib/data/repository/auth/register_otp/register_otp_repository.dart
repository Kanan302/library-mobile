import '../../../entity/auth/register_otp/register_otp_entity.dart';

abstract class IRegisterOtpRepository {
  Future<void> sendRegisterOtp(RegisterOtpEntity entity);
}
