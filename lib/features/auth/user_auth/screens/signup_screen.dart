import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_event.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/features/auth/user_auth/screens/login_screen.dart';
import 'package:pawpal/features/auth/widgets/textfield.dart';
import 'package:pawpal/features/common/screens/homescreen.dart';
import 'package:pawpal/features/common/widgets/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      final String firstName = firstNameController.text.trim();
      final String lastName = lastNameController.text.trim();
      final String username = userNameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      BlocProvider.of<UserAuthBloc>(context).add(UserAuthRegisterRequested(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        username: username,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
          if (state is UserRegisterLoading) {
            // Show loading dialog while waiting for response
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          } else if (state is UserRegisterSuccess) {
            // Close loading dialog
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (state is UserRegisterFailure) {
            // Close loading dialog
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is UserAuthSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (state is UserAuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<UserAuthBloc, UserAuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      SvgPicture.asset(
                        AppVectors.splashScreenLogo,
                        width: 100.0,
                        height: 100.0,
                      ),
                      const SizedBox(height: 10.0),
                      const WelcomeTexts(),
                      const SizedBox(height: 50.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomFormField(
                            labelText: 'First Name',
                            controller: firstNameController,
                            hintText: 'Enter your first name',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20.0),
                          CustomFormField(
                            labelText: 'Last Name',
                            controller: lastNameController,
                            hintText: 'Enter your last name',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20.0),
                          CustomFormField(
                            labelText: 'Username',
                            controller: userNameController,
                            hintText: 'Enter a unique username',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20.0),
                          CustomFormField(
                            labelText: 'Email',
                            controller: emailController,
                            hintText: 'Enter your email',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20.0),
                          CustomFormField(
                            labelText: 'Password',
                            controller: passwordController,
                            hintText: 'Enter a strong password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 30.0),
                          MediumButton(
                            color: AppColors.accentYellow,
                            text: 'Sign Up',
                            onPressed: _onSignUpPressed,
                          ),
                          const SizedBox(height: 30.0),
                          _buildLoginSection(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Already have an account?',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text(
            'Log In',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.accentRed,
                ),
          ),
        ),
      ],
    );
  }
}

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
          'Let\'s Get Started!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
