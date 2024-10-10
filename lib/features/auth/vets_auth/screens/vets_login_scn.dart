import 'package:flutter/material.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_event.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_state.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_register_scn.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:pawpal/features/vets/screens/feedback_screen.dart';
import 'package:pawpal/features/vets/screens/vets_dashboard_scn.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';


class VetsLoginScreen extends StatefulWidget {
  const VetsLoginScreen({super.key});

  @override
  _VetsLoginScreenState createState() => _VetsLoginScreenState();
}

class _VetsLoginScreenState extends State<VetsLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      context.read<VetAuthBloc>().add(VetAuthLoginRequested(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veterinarian Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text(
              'Login to your Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            BlocConsumer<VetAuthBloc, VetAuthState>(
              listener: (context, state) {
                if (state is VetAuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VetsDashboardScn(),
                    ),
                  );
                } else if (state is VetAuthFailure) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.error),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is VetAuthLoading) {
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don’t have an account? '),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const VetsRegisterScreen()),
                    );
                  },
                  child: Text(
                    'Register here',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
