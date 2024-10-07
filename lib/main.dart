import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pawpal/FirebaseTestPage%20.dart';
import 'package:pawpal/features/vets/screens/vets_home_screen.dart';
import 'firebase_options.dart';
import 'package:pawpal/features/splash/screens/splash_screen.dart';
//import 'package:pawpal/features/vets/screens/vets_home_screen.dart';
import 'package:pawpal/theme/theme.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // home:  FirebaseTestPage());

        theme: AppTheme.lightTheme,
        home: SplashScreen());
  }
}
