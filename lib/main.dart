import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/auth/bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_login_scn.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_register_scn.dart';
import 'package:pawpal/features/vets/screens/edit_vet_profile_screen.dart';
import 'package:pawpal/features/vets/screens/feedback_screen.dart';
import 'package:pawpal/features/vets/screens/manage_appointment.dart';
import 'package:pawpal/features/vets/screens/msg_list_screeen.dart';
import 'package:pawpal/features/vets/screens/msg_one_screen.dart';
import 'package:pawpal/features/vets/screens/vet_profile_screen.dart';
import 'package:pawpal/features/vets/screens/vets_appointment.dart';
import 'package:pawpal/features/vets/screens/vets_dashboard_scn.dart';
import 'package:pawpal/features/vets/screens/vets_list_screen.dart';
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
        BlocProvider(
          create: (context) => VetAuthBloc(AuthService(), FirestoreService()),
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
