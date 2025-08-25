import 'package:flutter/material.dart';

import '../../../../../shared/constants/ui_colors.dart';

class CreateBookPage extends StatelessWidget {
  const CreateBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.background,
      appBar: AppBar(backgroundColor: UiColors.background),
      body: SafeArea(child: Center(child: Text('create book page'))),
    );
  }
}
