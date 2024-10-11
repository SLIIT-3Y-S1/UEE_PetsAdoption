import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_event.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_state.dart';
import 'package:pawpal/features/auth/user_auth/screens/login_screen.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_register_scn.dart';
import 'package:pawpal/features/vets/screens/vets_dashboard_scn.dart';
import 'package:pawpal/features/common/widgets/medium_button.dart';
import 'package:pawpal/features/auth/widgets/textfield.dart';

class VetsLoginScreen extends StatefulWidget {
  const VetsLoginScreen({super.key});

  @override
  _VetsLoginScreenState createState() => _VetsLoginScreenState();
}

class _VetsLoginScreenState extends State<VetsLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context
          .read<VetAuthBloc>()
          .add(VetAuthLoginRequested(email: email, password: password));
    }
  }

  void _onUserLoginPressed() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<VetAuthBloc, VetAuthState>(
        listener: (context, state) {
          if (state is VetAuthLoading) {
            _showLoadingDialog(context);
          } else if (state is VetAuthSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VetsDashboardScn()),
            );
          } else if (state is VetAuthFailure) {
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
                    controller: _emailController,
                    hintText: 'Enter your email',
                    obscureText: false,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomFormField(
                    labelText: 'Password',
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.03),
                  MediumButton(
                    color: AppColors.accentYellow,
                    text: 'Login',
                    onPressed: handleLogin,
                  ),
                  TextButton(
                    onPressed: _onUserLoginPressed,
                    child: Text('Login as a User',
                        style: TextStyle(
                            color: AppColors.accentYellow, fontSize: 16)),
                  ),
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

  Widget _buildRegisterSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'New to pawpal?',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.black),
        ),
        SizedBox(height: size.height * 0.01),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const VetsRegisterScreen()),
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
}

class WelcomeTexts extends StatelessWidget {
  const WelcomeTexts({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Welcome Veterinarian!',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          'Login to continue',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
