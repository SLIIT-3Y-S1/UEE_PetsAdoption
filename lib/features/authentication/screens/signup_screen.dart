import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpal/common/widgets/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/authentication/screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
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
                  const _FirstName(),
                  const SizedBox(height: 20.0),
                  const _LastName(),
                  const SizedBox(height: 20.0),
                  const _UserName(),
                  const SizedBox(height: 20.0),
                  const _EmailTextField(),
                  const SizedBox(height: 20.0),
                  const _PasswordTextField(),
                  const SizedBox(height: 30.0),
                  MediumButton(
                    color: AppColors.accentYellow,
                    text: 'Sign Up',
                    onPressed: () {
                      // Handle login logic here
                    },
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'Already have an account ?',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Log In',
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
          'Create a New Account',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Let\'s Get Started !',
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

class _FirstName extends StatelessWidget {
  const _FirstName({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'Enter your first name',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _LastName extends StatelessWidget {
  const _LastName({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Enter your last name',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Enter a unique username',
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
