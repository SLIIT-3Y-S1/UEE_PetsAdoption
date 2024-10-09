import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpal/blocs/auth_bloc/authentication_bloc.dart';
import 'package:pawpal/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pawpal/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pawpal/core/data/model/models.dart';
import 'package:pawpal/features/authentication/textfield.dart';
import 'package:pawpal/widgets/common/medium_button.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/authentication/screens/login_screen.dart';

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
  bool signUpRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    const SizedBox(height: 20.0),
                    SvgPicture.asset(
                      AppVectors.splashScreenLogo,
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(height: 10.0),
                    const WelcomeTexts(),
                    const SizedBox(height: 10.0)
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomFormField(
                          labelText: 'First Name',
                          controller: firstNameController,
                          hintText: 'Enter your first name',
                          obscureText: false),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                          labelText: 'Last Name',
                          controller: lastNameController,
                          hintText: 'Enter your last name',
                          obscureText: false),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                          labelText: 'Username',
                          controller: userNameController,
                          hintText: 'Enter a unique username',
                          obscureText: false),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                          labelText: 'Email',
                          controller: emailController,
                          hintText: 'Enter your email',
                          obscureText: false),
                      const SizedBox(height: 20.0),
                      CustomFormField(
                          labelText: 'Password',
                          controller: passwordController,
                          hintText: 'Enter a strong password',
                          obscureText: true),
                      const SizedBox(height: 30.0),
                      MediumButton(
                        color: AppColors.accentYellow,
                        text: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserModel newUser = UserModel.empty;
                            newUser = newUser.copyWith(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                userName: userNameController.text,
                                email: emailController.text);
                            setState(() {
                              context.read<SignUpBloc>().add(SignUpRequired(
                                  user: newUser,
                                  password: passwordController.text));
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        'Already have an account ?',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
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
                                    BlocProvider<SignInBloc>(
                                      create: (context) => SignInBloc(
                                          userRepository: context
                                              .read<AuthenticationBloc>()
                                              .userRepository),
                                      child: const LoginScreen(),
                                    )),
                          );
                        },
                        child: Text(
                          'Log In',
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
