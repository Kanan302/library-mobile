import 'package:flutter/material.dart';

class UiValidators {
  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "E-poçt ünvanınızı daxil edin";
    }
    return null;
  }

  static String? writeMail(String? value) {
    if (value == null || value.isEmpty) {
      return "E-poçt boş ola bilməz";
    }
    if (!value.contains('@')) {
      return "E-poçt ünvanında '@' işarəsi olmalıdır";
    }
    return null;
  }

  static String? writePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifrənizi daxil edin";
    }
    if (value.length < 6) {
      return "Şifrə ən azı 6 simvoldan ibarət olmalıdır";
    }
    return null;
  }

  static String? confirmPassword(String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) {
      return "Şifrənizi daxil edin";
    }
    if (value.length < 6) {
      return "Şifrə ən azı 6 simvoldan ibarət olmalıdır";
    }
    if (value != passwordController.text) {
      return "Şifrələr eyni deyil";
    }
    return null;
  }

  static String? writeOtp(String? value) {
    if (value == null || value.isEmpty) {
      return "Sahə mütləqdir";
    }
    return null;
  }
}
