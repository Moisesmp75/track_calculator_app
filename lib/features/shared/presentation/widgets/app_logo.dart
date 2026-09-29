import 'package:flutter/material.dart';
import 'package:vehicle_calculator/core/config/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 250,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          AppAssets.logo,
          // width: size,
          // height: size,
          fit: BoxFit.contain,
          semanticLabel: 'SmartHaul',
        ),
      ),
    );
  }
}
