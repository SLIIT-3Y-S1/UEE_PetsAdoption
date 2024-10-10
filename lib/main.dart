import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pawpal/features/discussions/screens/discussion_home_screen.dart';

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
      debugShowCheckedModeBanner: false,
        title: 'PawPal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 9, 8, 10)),
          useMaterial3: true,
        ),
        home: const DiscussionsHomeScreen());
  }
}
