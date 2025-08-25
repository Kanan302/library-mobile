import 'package:flutter/material.dart';

import '../../../../../shared/constants/ui_colors.dart';

class CreateAuthorPage extends StatelessWidget {
  const CreateAuthorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(backgroundColor: UiColors.background),
      body: SafeArea(child: Center(child: Text('create author page'))),
    );
  }
}
