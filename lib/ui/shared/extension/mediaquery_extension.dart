import 'dart:math';
import 'package:flutter/material.dart';

extension MediaQueryExtension on num {
  double width(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 390);

  double height(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 844);

  double minimum(BuildContext context) =>
      min(width(context), height(context));

  double maximum(BuildContext context) =>
      max(width(context), height(context));

  double stWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * this;

  double stHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * this;

  double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).viewPadding.bottom * this;

  double topPadding(BuildContext context) =>
      MediaQuery.of(context).viewPadding.top * this;

  /// horizontal space
  SizedBox horizontal(BuildContext context) => SizedBox(width: width(context));

  /// vertical space
  SizedBox vertical(BuildContext context) => SizedBox(height: height(context));
}