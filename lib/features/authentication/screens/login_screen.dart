import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/blocs/auth_bloc/authentication_bloc.dart';
import 'package:pawpal/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pawpal/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pawpal/features/authentication/textfield.dart';

import 'package:pawpal/widgets/common/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/authentication/screens/signup_screen.dart';

/*main screen class*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool signInRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(() {
              signInRequired = false;
              // _errorMsg = 'Invalid email or password';
            });
          }
        },
        child: Form(
          key: _formKey,
          child: Scaffold(
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
                        CustomFormField(
                            labelText: 'Email',
                            controller: emailController,
                            hintText: 'Enter your email',
                            obscureText: false),
                        const SizedBox(height: 30.0),
                        CustomFormField(
                            labelText: 'Password',
                            controller: passwordController,
                            hintText: 'Enter your password',
                            obscureText: true),
                        const SizedBox(height: 30.0),
                        MediumButton(
                          color: AppColors.accentYellow,
                          text: 'Login',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                context.read<SignInBloc>().add(
                                      SignInRequired(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 30.0),
                        Text(
                          'New to pawpal?',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlocProvider<SignUpBloc>(
                                        create: (context) => SignUpBloc(
                                            userRepository: context
                                                .read<AuthenticationBloc>()
                                                .userRepository),
                                        child: const SignupScreen(),
                                      )),
                            );
                          },
                          child: Text(
                            'Register now',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
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
          ),
        ));
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
