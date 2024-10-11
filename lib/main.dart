import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/user_auth/screens/login_screen.dart';
import 'package:pawpal/features/auth/user_auth/user_auth_services/user_firebase_services.dart';
import 'package:pawpal/features/common/screens/splash_screen.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_bloc.dart';

import 'firebase_options.dart';
import 'package:pawpal/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<VetAuthBloc>(
          create: (context) => VetAuthBloc(AuthService(), FirestoreService()),
        ),
        BlocProvider<UserAuthBloc>(
          create: (context) =>
              UserAuthBloc(AuthService(), UserFirebaseServices()),
        ),
        BlocProvider<VetBloc>(
          create: (context) => VetBloc(FirestoreService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PawPal',
        theme: AppTheme.lightTheme,
        home: const SplashScreen());
  }
}
