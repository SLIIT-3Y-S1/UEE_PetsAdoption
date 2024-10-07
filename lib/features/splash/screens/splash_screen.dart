import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/core/assets/app_vectors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppVectors.splashScreenLogo),
            const SizedBox(height: 10), // Add some space between the logo and branding
            SvgPicture.asset(AppVectors.splashScreenBranding),
          ],
        ),
      ),
    );
  }
}
