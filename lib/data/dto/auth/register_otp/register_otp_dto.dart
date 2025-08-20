class RegisterOtpDto {
  final String email;
  final String password;

  RegisterOtpDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory RegisterOtpDto.fromJson(Map<String, dynamic> json) =>
      RegisterOtpDto(email: json['email'], password: json['password']);
}
