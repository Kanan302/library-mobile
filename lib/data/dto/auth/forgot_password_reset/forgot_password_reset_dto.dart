class ForgotPasswordResetDto {
  final String newPassword;

  ForgotPasswordResetDto({required this.newPassword});

  Map<String, dynamic> toJson() => {'newPassword': newPassword};

  factory ForgotPasswordResetDto.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResetDto(newPassword: json['newPassword']);
}
