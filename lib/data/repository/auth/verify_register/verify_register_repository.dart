import '../../../entity/auth/verify_register/verify_register_entity.dart';

abstract class IVerifyRegisterRepository {
  Future<void> verifyRegister(VerifyRegisterEntity entity);
}
