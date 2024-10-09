import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:pawpal/features/postings/screens/postings_screen.dart';
import 'package:pawpal/features/splash/screens/splash_screen.dart';
import 'package:pawpal/firebase_options.dart';
import 'package:pawpal/simple_bloc_observer.dart';
import 'package:pawpal/theme/theme.dart';
//import 'package:path_provider/path_provider.dart';


Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Bloc.observer = SimpleBlocObserver();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen());
  }
}
