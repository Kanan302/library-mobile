class VerifyRegisterDto {
  final String otpCode;

  VerifyRegisterDto({required this.otpCode});

  Map<String, dynamic> toJson() => {'otpCode': otpCode};

  factory VerifyRegisterDto.fromJson(Map<String, dynamic> json) => VerifyRegisterDto(otpCode: json['otpCode']);
}
