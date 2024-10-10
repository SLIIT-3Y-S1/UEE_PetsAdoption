import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_login_scn.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:pawpal/features/vets/screens/vets_dashboard_scn.dart';

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

  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  void _handleRegistration() async {
    var user = await _authService.signUpWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user == null) {
      // Handle registration error (show a message or log)
      return;
    } else {
      var vet = VetModel(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        clinicName: _currentClincNameController.text,
        clinicLocation: _clincLocation.text,
        nic: _nicController.text,
        vetLicenseNo: _vetLicenseNoControllr.text,
        issueDate: DateTime.parse(_licenseIssueDateController.text),
      );
      var savedVet = await _firestoreService.addVetToFirestore(vet);
      if (savedVet != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VetsDashboardScn(),
          ),
        );
        print('Vet successfully registered: ${savedVet.fullName}');
      } else {
        print('Failed to save vet data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarian Registration'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable swipe gestures
                  children: [
                    // First Screen: Basic Info
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'Step 1: Basic Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Please enter a password with at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _nextPage, // Go to next screen
                            child: Container(
                              width: 100.0,
                              child: Center(
                                child: Text("Next"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? "),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to login screen
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const VetsLoginScreen();
                                  }));
                                },
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
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'Step 2: Additional Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _currentClincNameController,
                            decoration: const InputDecoration(
                              labelText: 'Current Clinic Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your current clinic name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _clincLocation,
                            decoration: const InputDecoration(
                              labelText: 'Clinic Location',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your clinic location';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _nicController,
                            decoration: const InputDecoration(
                              labelText: 'NIC Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your NIC number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _vetLicenseNoControllr,
                            decoration: const InputDecoration(
                              labelText: 'Veterinarian License Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your license number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _licenseIssueDateController,
                            decoration: const InputDecoration(
                              labelText: 'License Issue Date',
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your license issue date';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed:
                                    _prevPage, // Go back to previous screen
                                child: const Text("Back"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _handleRegistration(); // Register the vet
                                },
                                child: const Text("Register"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
