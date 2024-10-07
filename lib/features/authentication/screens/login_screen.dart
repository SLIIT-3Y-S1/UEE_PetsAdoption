import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/common/widgets/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';

class WelcomeTexts extends StatelessWidget {
  const WelcomeTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          'Glad to see you again!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Sign Up Page'),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 32.0),
                SvgPicture.asset(AppVectors.loginScreenLogo),
                const WelcomeTexts(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  MediumButton(
                    color: AppColors.accentYellow,
                    text: 'Login',
                    onPressed: () {
                      // Handle login logic here
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'New to pawpal?',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: Text(
                      'Register now',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppColors.accentRed,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
