import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:library_app/ui/shared/extension/mediaquery_extension.dart';

import '../../../shared/constants/app_routes.dart';
import '../../shared/constants/ui_colors.dart';
import '../../shared/constants/ui_icons.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        context.go(AppRoutes.login.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(UiIcons.background, fit: BoxFit.cover)),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(UiIcons.logo),
                20.vertical(context),
                Text(
                  'Albrain Books',
                  style: TextStyle(color: UiColors.white, fontSize: 35, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
