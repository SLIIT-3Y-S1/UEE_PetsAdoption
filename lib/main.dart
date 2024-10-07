import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pawpal/features/splash/screens/splash_screen.dart';
//import 'package:pawpal/features/vets/screens/vets_home_screen.dart';
import 'package:pawpal/theme/theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PawPal',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen());
  }
}
