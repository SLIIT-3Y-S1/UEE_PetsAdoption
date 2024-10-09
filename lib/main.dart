import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/data/repository/implementations/user_imp.dart';
import 'package:pawpal/mainApp.dart';
import 'package:pawpal/firebase_options.dart';
import 'package:pawpal/simple_bloc_observer.dart';
//import 'package:pawpal/splash_screen.dart';


void main() async {
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
      builder: (context) => MainApp(UserImp()),
    ),
  );
}

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'PawPal',
  //       debugShowCheckedModeBanner: false,
  //       theme: AppTheme.lightTheme,
  //       home: const SplashScreen());
  // }

 