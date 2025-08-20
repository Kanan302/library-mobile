class ForgotPasswordOtpDto {
  final String otpCode;

  ForgotPasswordOtpDto({required this.otpCode});

  Map<String, dynamic> toJson() => {'otpCode': otpCode};

  factory ForgotPasswordOtpDto.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpDto(otpCode: json['otpCode']);
}
