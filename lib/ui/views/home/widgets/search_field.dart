import 'package:flutter/material.dart';
import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../shared/constants/ui_colors.dart';
import '../../../shared/constants/ui_strings.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  const SearchField({super.key, required this.controller, this.onChanged, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: UiStrings.search,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: UiColors.white,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: onChanged,
            ),
          ),
          10.horizontal(context),
          FloatingActionButton.small(
            heroTag: null,
            onPressed: onPressed,
            backgroundColor: UiColors.white,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
