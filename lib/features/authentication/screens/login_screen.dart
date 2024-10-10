import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_event.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';

import 'package:pawpal/features/authentication/screens/signup_screen.dart';
import 'package:pawpal/features/authentication/textfield.dart';
import 'package:pawpal/features/pet_posts/screens/pet_post_home_screeen.dart';
import 'package:pawpal/widgets/common/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context
          .read<UserAuthBloc>()
          .add(UserAuthLoginRequested(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
          if (state is UserAuthLoading) {
            _showLoadingDialog(
                context); // Show loading dialog while waiting for response
          } else if (state is UserAuthSuccess) {
            Navigator.pop(context); // Close loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PetPostHomeScreen(), // Navigate to the home screen after successful login
              ),
            );
          } else if (state is UserAuthFailure) {
            Navigator.pop(context); // Close loading dialog
            _showErrorSnackBar(context, state.error); // Show error message
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                SvgPicture.asset(
                  AppVectors.splashScreenLogo,
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 20.0),
                const WelcomeTexts(),
                const SizedBox(height: 50.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFormField(
                        labelText: 'Email',
                        controller: emailController,
                        hintText: 'Enter your email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 30.0),
                      CustomFormField(
                        labelText: 'Password',
                        controller: passwordController,
                        hintText: 'Enter your password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 30.0),
                      MediumButton(
                        color: AppColors.accentYellow,
                        text: 'Login',
                        onPressed: _onLoginPressed,
                      ),
                      const SizedBox(height: 30.0),
                      _buildRegisterSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Widget _buildRegisterSection(BuildContext context) {
  return Column(
    children: [
      Text(
        'New to pawpal?',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      const SizedBox(height: 10.0),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignupScreen()));
        },
        child: Text(
          'Register now',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.accentRed,
              ),
        ),
      ),
    ],
  );
}

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
