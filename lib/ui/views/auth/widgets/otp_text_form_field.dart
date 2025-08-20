import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/constants/ui_colors.dart';

class OtpTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? nextController;
  final TextEditingController? previousController;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;

  const OtpTextFormField({
    super.key,
    this.controller,
    this.nextController,
    this.previousController,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
  });

  @override
  State<OtpTextFormField> createState() => _OtpTextFormFieldState();
}

class _OtpTextFormFieldState extends State<OtpTextFormField> {
  late FocusNode keyListenerFocusNode;

  @override
  void initState() {
    super.initState();
    keyListenerFocusNode = FocusNode();
  }

  @override
  void dispose() {
    keyListenerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: keyListenerFocusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
          final text = widget.controller?.text ?? '';

          if (text.isNotEmpty) {
            // Cari input doludur, onu boşalt, amma əvvəlki controllerə toxunma
            widget.controller?.text = '';
            widget.controller?.selection = TextSelection.collapsed(offset: 0);

            // Fokus əvvəlki inputa keç
            if (widget.previousFocusNode != null) {
              widget.previousFocusNode!.requestFocus();
            }

            return KeyEventResult.handled;
          } else {
            // Input onsuz da boşdur, fokus əvvəlki inputa keç və boşaltma
            if (widget.previousFocusNode != null) {
              widget.previousFocusNode!.requestFocus();
            }
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UiColors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UiColors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: UiColors.error, width: 2),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: UiColors.error, width: 2),
          ),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isEmpty) {
            return;
          }

          if (value.length > 1) {
            widget.controller?.text = value[0];
            widget.controller?.selection = TextSelection.collapsed(offset: 1);

            if (widget.nextController != null && widget.nextFocusNode != null) {
              widget.nextController?.text = value.substring(1);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.nextFocusNode?.requestFocus();
                widget.nextController?.selection = TextSelection.collapsed(offset: widget.nextController!.text.length);
              });
            }
          } else if (value.length == 1) {
            if (widget.nextFocusNode != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.nextFocusNode?.requestFocus();
              });
            }
          }
        },
      ),
    );
  }
}
