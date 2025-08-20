import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../constants/ui_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? textColor;
  final Color buttonColor;
  final Color? sideColor;
  final BorderRadiusGeometry? borderRadius;
  final double? fontSize;
  final String? icon;
  final bool iconOnRight;
  final Color? iconColor;
  final bool isLoading;
  final bool centerText;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.text,
    this.textColor,
    required this.buttonColor,
    this.sideColor,
    this.borderRadius,
    this.fontSize,
    this.icon,
    this.iconOnRight = false,
    this.iconColor,
    this.isLoading = false,
    this.centerText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        side: sideColor != null ? BorderSide(color: sideColor!, width: 2) : null,
        shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child:
          isLoading
              ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: UiColors.white))
              : _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    // Icon da yox, Text də yox — boş widget
    if (icon == null && text == null) {
      return const SizedBox.shrink();
    }

    // Təkcə Icon varsa
    if (icon != null && text == null) {
      return SvgPicture.asset(
        icon!,
        colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
      );
    }

    // Təkcə Text varsa
    if (icon == null && text != null) {
      return Text(text!, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: fontSize));
    }

    // Həm Icon, həm Text varsa
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          iconOnRight
              ? [
                Text(
                  text!,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: fontSize),
                  textAlign: centerText ? TextAlign.center : TextAlign.start,
                ),
                12.horizontal(context),
                SvgPicture.asset(icon!),
              ]
              : [
                SvgPicture.asset(icon!),
                12.horizontal(context),
                Text(
                  text!,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: fontSize),
                  textAlign: centerText ? TextAlign.center : TextAlign.start,
                ),
              ],
    );
  }
}
