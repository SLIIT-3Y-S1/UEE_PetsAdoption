import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_login_scn.dart';
import 'package:pawpal/features/authentication/screens/login_screen.dart';
import 'package:pawpal/features/authentication/screens/signup_screen.dart';
import 'package:pawpal/features/authentication/services/user_firebase_services.dart';

import 'package:pawpal/features/discussions/screens/discussion_home_screen.dart';

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
      ],
      child: MyApp(),
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
        home: VetsLoginScreen());
  }
}
