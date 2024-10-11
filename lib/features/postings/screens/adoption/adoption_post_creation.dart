import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/features/auth/widgets/textfield.dart';
import 'package:pawpal/features/common/widgets/medium_button.dart';
import 'package:pawpal/models/user_model.dart';

class AdoptionPostCreation extends StatefulWidget {
  @override
  _AdoptionPostCreationState createState() => _AdoptionPostCreationState();
}

class _AdoptionPostCreationState extends State<AdoptionPostCreation> {
  @override
  void initState() {
    super.initState();
    // Assuming you have a UserBloc and it has a method to get the current user
    final userState = BlocProvider.of<UserAuthBloc>(context).state;

    if (userState is UserAuthSuccess || userState is UserRegisterSuccess) {
      // Casting the state to access user data
      UserModel user = (userState as dynamic).user;

      // Print the vet data in initState
      print("Vet Data on Init:");
      print("Name: ${user!.id}");
      print("Email: ${user!.email}");
    }
  }
  final _formKey = GlobalKey<FormState>();
  String? _palname;
  String? _type;
  String? _breed;
  List<XFile>? _images = [];

  bool _isVaccinated = false;
  bool _isTrained = false;
  String? _contact;
  String? _location;
  String? _description;

  final palname = TextEditingController();
  final animaltypecontroller = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                CustomFormField(
                  labelText: 'Pal\'s Name',
                  controller: palname,
                  hintText: 'Enter the name of your animal',
                  obscureText: false,
                ),
                SizedBox(height: size.height * 0.03),
                //Category dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your animal type',
                  ),
                  items: ['Dog', 'Cat', 'Bird', 'Snake', 'Rabbit', 'Other']
                      .map((category) => DropdownMenuItem(
                            child: Text(category),
                            value: category,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      var _category = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'Breed',
                      hintText: 'Enter the breed of your animal',
                    )),
                SizedBox(height: size.height * 0.03),

                //image picker
                Text("Add Images"),
                SizedBox(height: 10),
                Wrap(
                  children: [
                    ..._images!.map((image) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              Image.file(
                                File(image.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images!.remove(image);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    if (_images!.length < 5)
                      IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: _pickImages,
                      ),
                  ],
                ),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'Pal\'s Current Age',
                      hintText: 'Enter the breed of your animal',
                    )),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      hintText: 'Enter pal\'s weight in kilograms',
                    )),
                SizedBox(height: size.height * 0.03),

                // Vaccinated Checkbox
                Row(
                  children: [
                    Text("Is your pal vaccinated ?"),
                    Checkbox(
                      value: _isVaccinated,
                      onChanged: (value) {
                        setState(() {
                          _isVaccinated = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    Text("Is your pal trained ?"),
                    Checkbox(
                      value: _isTrained,
                      onChanged: (value) {
                        setState(() {
                          _isTrained = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'Contact Number',
                      hintText: 'Enter your contact number',
                    )),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      hintText: 'Enter the city where the animal is located at',
                    )),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                    maxLength: 24,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter the address of your animal',
                    )),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter a age of your animal',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),

                SizedBox(height: size.height * 0.03),
                const MediumButton(
                  color: AppColors.accentYellow,
                  text: 'Create Post',
                  onPressed: _onSubmissionPressed,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       _formKey.currentState!.save();
                //       // Handle the form submission
                //       print('Pet Name: $_petName');
                //       print('Description: $_description');
                //       print('Contact Info: $_contactInfo');
                //     }
                //   },
                //   child: const Text('Submit'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _onSubmissionPressed() {
  // if (_formKey.currentState!.validate()) {
  //   _formKey.currentState!.save();
  //   // Handle the form submission
  //   print('Pet Name: $_petName');
  //   print('Description: $_description');
  //   print('Contact Info: $_contactInfo');
  // }
}
