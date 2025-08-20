import 'package:flutter/material.dart';

import 'ui_strings.dart';

class UiValidators {
  static String? writeMail(String? value) {
    if (value == null || value.isEmpty) {
      return UiStrings.emailCannotBeEmpty;
    }
    if (!value.contains('@')) {
      return UiStrings.emailMustContainAt;
    }
    return null;
  }

  static String? writePassword(String? value) {
    if (value == null || value.isEmpty) {
      return UiStrings.passwordCannotBeEmpty;
    }
    if (value.length < 6) {
      return UiStrings.passwordTooShort;
    }
    return null;
  }

  static String? confirmPassword(String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) {
      return UiStrings.passwordCannotBeEmpty;
    }
    if (value.length < 6) {
      return UiStrings.passwordTooShort;
    }
    if (value != passwordController.text) {
      return UiStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? writeOtp(String? value) {
    if (value == null || value.isEmpty) {
      return UiStrings.requiredField;
    }
    return null;
  }
}
