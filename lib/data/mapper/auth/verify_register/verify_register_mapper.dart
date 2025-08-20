import '../../../dto/auth/verify_register/verify_register_dto.dart';
import '../../../entity/auth/verify_register/verify_register_entity.dart';

extension VerifyRegisterMapper on VerifyRegisterEntity {
  VerifyRegisterDto toDto() {
    return VerifyRegisterDto(otpCode: otpCode);
  }
}
