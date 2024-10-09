import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/widgets/common/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/authentication/screens/signup_screen.dart';


/*main screen class*/

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                const SizedBox(height: 30.0),
                SvgPicture.asset(
                  AppVectors.splashScreenLogo,
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 20.0),
                const WelcomeTexts(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const _EmailTextField(),
                  const SizedBox(height: 30.0),
                  const _PasswordTextField(),
                  const SizedBox(height: 30.0),
                  MediumButton(
                    color: AppColors.accentYellow,
                    text: 'Login',
                    onPressed: () {
                      // Handle login logic here
                    },
                  ),
                  const SizedBox(height: 30.0),
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
                            builder: (context) => SignupScreen()),
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

/*inner widget element definitions*/

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
        const SizedBox(height: 10.0),
        Text(
          'Glad to see you again!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
    );
  }
}
