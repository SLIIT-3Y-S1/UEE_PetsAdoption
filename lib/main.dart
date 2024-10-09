import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
<<<<<<< HEAD
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
=======
import 'package:pawpal/features/donations/screens/donation_home_screen.dart';
// import 'package:pawpal/features/vets/screens/vets_home_screen.dart';
>>>>>>> c6ddfcc (Created screens of Donation System)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // const MyApp(),
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
<<<<<<< HEAD
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // home:  FirebaseTestPage());

        theme: AppTheme.lightTheme,
        home: VetsLoginScreen());
=======
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DonationHomeScreen());
>>>>>>> c6ddfcc (Created screens of Donation System)
  }
}
