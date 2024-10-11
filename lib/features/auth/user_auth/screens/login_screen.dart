import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_event.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';

import 'package:pawpal/features/auth/user_auth/screens/signup_screen.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_login_scn.dart';
import 'package:pawpal/features/auth/widgets/textfield.dart';
import 'package:pawpal/features/common/screens/homescreen.dart';

import 'package:pawpal/features/common/widgets/medium_button.dart';
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

  void _onVetLoginPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const VetsLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
          if (state is UserAuthLoading) {
            _showLoadingDialog(context);
          } else if (state is UserAuthSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is UserAuthFailure) {
            Navigator.pop(context);
            _showErrorSnackBar(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.05,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                  SvgPicture.asset(
                    AppVectors.splashScreenLogo,
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                  ),
                  SizedBox(height: size.height * 0.03),
                  const WelcomeTexts(),
                  SizedBox(height: size.height * 0.06),
                  CustomFormField(
                    labelText: 'Email',
                    controller: emailController,
                    hintText: 'Enter your email',
                    obscureText: false,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomFormField(
                    labelText: 'Password',
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.03),
                  MediumButton(
                    color: AppColors.accentYellow,
                    text: 'Login',
                    onPressed: _onLoginPressed,
                  ),
                  // SizedBox(height: size.height * 0.03),
                  TextButton(
                    onPressed: _onVetLoginPressed,
                    child: Text('Login as a Vet',
                        style: TextStyle(
                            color: AppColors.accentYellow, fontSize: 16)),
                  ),
                  // SizedBox(height: size.height * 0.03),
                  _buildRegisterSection(context),
                ],
              ),
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
  final size = MediaQuery.of(context).size;
  return Column(
    children: [
      Text(
        'New to pawpal?',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      SizedBox(height: size.height * 0.01),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupScreen()),
          );
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
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          'Glad to see you again!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
