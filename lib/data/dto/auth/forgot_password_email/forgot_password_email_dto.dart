class ForgotPasswordEmailDto {
  final String email;

  ForgotPasswordEmailDto({required this.email});

  Map<String, dynamic> toJson() => {'email': email};

  factory ForgotPasswordEmailDto.fromJson(Map<String, dynamic> json) => ForgotPasswordEmailDto(email: json['email']);
}
