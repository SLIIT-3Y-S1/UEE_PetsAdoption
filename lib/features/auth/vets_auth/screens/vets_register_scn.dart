import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_event.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_state.dart';
import 'package:pawpal/features/auth/widgets/welcome_widget.dart';
import 'package:pawpal/features/vets/screens/vets_dashboard_scn.dart';
import 'package:pawpal/features/auth/vets_auth/screens/vets_login_scn.dart';

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
  final TextEditingController _vetLicenseNoController = TextEditingController();
  final TextEditingController _licenseIssueDateController =
      TextEditingController();
  final TextEditingController _currentClinicNameController =
      TextEditingController();
  final TextEditingController _clinicLocationController =
      TextEditingController();

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

  // Function to open the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
    setState(() {
      _licenseIssueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }
}

  void _handleRegistration(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String fullName = _nameController.text.trim();
      final String phone = _phoneController.text.trim();
      final String clinicLocation = _clinicLocationController.text.trim();
      final String clinicName = _currentClinicNameController.text.trim();
      final String nic = _nicController.text.trim();
      final String vetLicenseNo = _vetLicenseNoController.text.trim();
      final String issueDate = _licenseIssueDateController.text.trim();

      BlocProvider.of<VetAuthBloc>(context).add(VetAuthRegisterRequested(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        clinicLocation: clinicLocation,
        nic: nic,
        vetLicenseNo: vetLicenseNo,
        clinicName: clinicName,
        issueDate: DateTime.parse(issueDate),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: BlocListener<VetAuthBloc, VetAuthState>(
            listener: (context, state) {
              if (state is VetRegisterLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is VetRegisterSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VetsDashboardScn()),
                  (route) => false,
                );
              } else if (state is VetRegisterFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
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
                      const WelcomeWidget(),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
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
                                  _buildTextField(
                                      label: 'Full Name',
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                      label: 'Email',
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value == null ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                      label: 'Phone Number',
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    label: 'Password',
                                    controller: _passwordController,
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
                                  _buildTextField(
                                    label: 'Confirm Password',
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 120, // Set the desired width
                                    height: 40, // Set the desired height
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: AppColors.white,
                                        backgroundColor: AppColors.accentYellow,
                                        shadowColor: AppColors.secondary,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
                                      onPressed: _nextPage,
                                      child: const Text(
                                        'Next',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildLoginSection(context),
                                ],
                              ),
                            ),
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
                                  _buildTextField(
                                      label: 'Current Clinic Name',
                                      controller: _currentClinicNameController),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                      label: 'Clinic Location',
                                      controller: _clinicLocationController),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                      label: 'NIC Number',
                                      controller: _nicController),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                      label: 'Veterinarian License Number',
                                      controller: _vetLicenseNoController),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    label: 'License Issue Date',
                                    controller: _licenseIssueDateController,
                                    readOnly: true,
                                    onTap: () => _selectDate(context),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 120, // Set the desired width
                                        height: 40, // Set the desired height
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: AppColors.black,
                                            backgroundColor:
                                                AppColors.accentYellow,
                                            shadowColor: AppColors.secondary,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            _pageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: const Text('Back'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120, // Set the desired width
                                        height: 40, // Set the desired height
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: AppColors.black,
                                            backgroundColor:
                                                AppColors.accentYellow,
                                            shadowColor: AppColors.secondary,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                          ),
                                          onPressed: () =>
                                              _handleRegistration(context),
                                          child: const Text('Register'),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _buildLoginSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Already have an account?',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VetsLoginScreen()),
            );
          },
          child: Text(
            'Login here',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.accentRed,
                  fontWeight: FontWeight.bold,
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
          'Join Us!',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.accentRed,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Create your vet account.',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}

// Helper method to create text fields
Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  String? Function(String?)? validator,
  bool obscureText = false,
  VoidCallback? onTap,
  bool readOnly = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    readOnly: readOnly,
    validator: validator,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}
