import '../../../dto/auth/login/login_dto.dart';
import '../../../entity/auth/login/login_entity.dart';

extension LoginMapper on LoginEntity {
  LoginDto toDto() {
    return LoginDto(email: email, password: password);
  }
}
