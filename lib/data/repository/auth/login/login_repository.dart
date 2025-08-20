import '../../../entity/auth/login/login_entity.dart';

abstract class ILoginRepository {
  Future<void> login(LoginEntity entity);
}
