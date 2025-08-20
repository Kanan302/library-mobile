import 'package:flutter/material.dart';

import '../shared/services/navigation/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: "Library", routerConfig: AppRouter.router, debugShowCheckedModeBanner: false);
  }
}
