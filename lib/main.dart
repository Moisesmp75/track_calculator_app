import 'package:flutter/material.dart';
import 'package:vehicle_calculator/router/go_router.dart';
// import 'package:vehicle_calculator/theme/dark_theme.dart';

import 'package:vehicle_calculator/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: lightColorScheme),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
