import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VetsRegisterScreen extends StatefulWidget {
  const VetsRegisterScreen({super.key});

  @override
  _VetsRegisterScreenState createState() => _VetsRegisterScreenState();
}

class _VetsRegisterScreenState extends State<VetsRegisterScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _vetLicenseNoControllr = TextEditingController();
  final TextEditingController _licenseIssueDateController =
      TextEditingController();
  final TextEditingController _currentClincNameController =
      TextEditingController();
  final TextEditingController _clincLocation = TextEditingController();

  int _currentPage = 0;
  bool _isAlreadyRegistered = false; // Toggle state

  // Function to move to the next screen
  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  // Function to move back to the previous screen
  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPage--;
    });
  }

  // Function to open the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1900), // Starting date range
      lastDate: DateTime.now(), // Ending date range (current date)
    );

    if (pickedDate != null) {
      setState(() {
        // Format the date and set it in the TextFormField
        _licenseIssueDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  // Function to toggle between login and register screens
  void _toggleAlreadyRegistered() {
    setState(() {
      _isAlreadyRegistered = !_isAlreadyRegistered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isAlreadyRegistered
            ? 'Veterinarian Login'
            : 'Veterinarian Registration'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: _isAlreadyRegistered
          ? _buildLoginForm(context) // Show login form
          : _buildRegisterForm(context), // Show registration form
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Padding(
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
                  // Handle login logic here
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: _toggleAlreadyRegistered,
                  child: Text(
                    'Register here',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
        children: [
          // First Screen: Basic Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Step 1: Basic Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextPage, // Go to next screen
                  child: const Text('Next'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: _toggleAlreadyRegistered,
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Second Screen: More Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Step 2: Additional Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nicController,
                  decoration: const InputDecoration(
                    labelText: 'NIC Number',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter NIC number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _vetLicenseNoControllr,
                  decoration: const InputDecoration(
                    labelText: 'Veterinary License Number',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Veterinary License Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _licenseIssueDateController,
                  decoration: const InputDecoration(
                    labelText: 'License Issue Date',
                  ),
                  readOnly: true, // Prevents keyboard from appearing
                  onTap: () => _selectDate(context), // Opens date picker
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select License Issue Date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _prevPage, // Go back to the first screen
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Register the vet
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
