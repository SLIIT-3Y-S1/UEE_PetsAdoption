import 'package:flutter/material.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_register_scn.dart';
import 'package:pawpal/features/vets/screens/feedback_screen.dart';

class VetsLoginScreen extends StatefulWidget {
  const VetsLoginScreen({super.key});

  @override
  _VetsLoginScreenState createState() => _VetsLoginScreenState();
}

class _VetsLoginScreenState extends State<VetsLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isNotRegistered = false;

  // Function to toggle registration state
  void _toggleRegisterState() {
    setState(() {
      _isNotRegistered = !_isNotRegistered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veterinarian Login'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Login to your Account',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
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
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle login
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isNotRegistered
                      ? 'Already have an account? '
                      : 'Don’t have an account? '),
                  GestureDetector(
                    onTap: _toggleRegisterState,
                    child: Text(
                      _isNotRegistered ? 'Login here' : 'Register here',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (_isNotRegistered)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to registration screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VetsRegisterScreen()),
                        );
                      },
                      child: const Text('Register as a Veterinarian'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
