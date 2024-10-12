import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/features/auth/widgets/textfield.dart';
import 'package:pawpal/features/common/screens/homescreen.dart';
import 'package:pawpal/features/common/widgets/medium_button.dart';
import 'package:pawpal/features/postings/models/adoption_post_model.dart';
import 'package:pawpal/features/postings/services/adoption_firestore_service.dart';
import 'package:pawpal/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AdoptionPostCreation extends StatefulWidget {
  @override
  _AdoptionPostCreationState createState() => _AdoptionPostCreationState();
}

class _AdoptionPostCreationState extends State<AdoptionPostCreation> {
  @override
  void initState() {
    super.initState();
    final userState = BlocProvider.of<UserAuthBloc>(context).state;
    if (userState is UserAuthSuccess || userState is UserRegisterSuccess) {
      UserModel user = (userState as dynamic).user;
      // print("Vet Data on Init:");
      // print("Name: ${user!.id}");
      // print("Email: ${user!.email}");
    }
  }

  //loading state
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  //field controllers
  final TextEditingController _palnameController = TextEditingController();
  final TextEditingController _animalTypeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();

  List<XFile>? _images = []; //image

  //field controllers
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  bool _isVaccinated = false;
  bool _isTrained = false;
  String? _gender;

  double? _age;
  double? _weight;

  final AdoptionFirestoreService _firestoreService = AdoptionFirestoreService();

  //image picker validation
  Future<void> _pickImages() async {
    if (_images!.length >= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only upload one image.')),
      );
      return;
    }

    //save image to _images ( caching )
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images = [pickedFile];
      });
    }
  }

  //method : file upload to firebase storage
  Future<String> _uploadImage(XFile image) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('animal/adoption/${image.name}');
    final uploadTask = storageRef.putFile(File(image.path));
    final snapshot = await uploadTask.whenComplete(() => {});
    return await snapshot.ref.getDownloadURL();
  }

  void _onSubmissionPressed() async {
    //initial validation and null check
    if (_formKey.currentState!.validate()) {
      if (_images == null || _images!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please add at least one image.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      _formKey.currentState!.save();
      _age = double.tryParse(_ageController.text);
      _weight = double.tryParse(_weightController.text);

      //get user email from user auth bloc
      String? userEmail;
      final userState = BlocProvider.of<UserAuthBloc>(context).state;
      if (userState is UserAuthSuccess || userState is UserRegisterSuccess) {
        UserModel user = (userState as dynamic).user;
        userEmail = user!.email;
      }

      // print("User Email: $userEmail");
      // print('Pal Name: ${_palnameController.text}');
      // print('Animal Type: ${_animalTypeController.text}');
      // print('Breed: ${_breedController.text}');
      // print('Age: $_age');
      // print('Weight: $_weight');
      // print('Description: ${_descriptionController.text}');
      // print('Contact Number: ${_contactNumberController.text}');
      // print('City: ${_cityController.text}');
      // print('Address: ${_addressController.text}');
      // print('Is Vaccinated: $_isVaccinated');
      // print('Is Trained: $_isTrained');
      // print('Images: ${_images!.map((image) => image.path).join(', ')');

      //uploading data to firebase and firestore flow
      try {
        final imageUrl = await _uploadImage(_images!.first); // upload image
        print('Image uploaded successfully: $imageUrl');

        //map to adoption post model
        final post = AdoptionPostModel(
          email: userEmail!,
          palname: _palnameController.text,
          animalType: _animalTypeController.text,
          breed: _breedController.text,
          imageUrl: imageUrl,
          age: _age!,
          weight: _weight!,
          description: _descriptionController.text,
          isVaccinated: _isVaccinated ? 'Yes' : 'No',
          isTrained: _isTrained ? 'Yes' : 'No',
          contactNumber: int.parse(_contactNumberController.text),
          city: _cityController.text,
          address: _addressController.text,
          gender: _gender!,
          availability: 'Available',
          timestamp:DateTime.now(),
          //postid: const Uuid().v4().toString(),
        );

        //upload firestore database
        await _firestoreService.createAdoptionPost(post);

        //on success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Adoption post created successfully!')),
        );

        // Navigate back to HomeScreen using MaterialPageRoute
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } on Exception catch (e) {
        // Handle the error, e.g., show a snackbar or log the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    CustomFormField(
                      labelText: 'Pal\'s Name',
                      controller: _palnameController,
                      hintText: 'Enter the name of your animal',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name of your animal';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      children: [
                        Text("Gender: "),
                        Checkbox(
                          value: _gender == 'Male',
                          onChanged: (value) {
                            setState(() {
                              _gender = value! ? 'Male' : null;
                            });
                          },
                        ),
                        Text("Male"),
                        Checkbox(
                          value: _gender == 'Female',
                          onChanged: (value) {
                            setState(() {
                              _gender = value! ? 'Female' : null;
                            });
                          },
                        ),
                        Text("Female"),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
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
                          _animalTypeController.text = value!;
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
                      controller: _breedController,
                      maxLength: 24,
                      decoration: const InputDecoration(
                        labelText: 'Breed',
                        hintText: 'Enter the breed of your animal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the breed of your animal';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
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
                        if (_images!.length < 1)
                          IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: _pickImages,
                          ),
                      ],
                    ),
                    TextFormField(
                      controller: _ageController,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Pal\'s Current Age',
                        hintText: 'Enter the age of your pal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter current age of your pal in years';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: _weightController,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        hintText: 'Enter pal\'s weight in kilograms',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the weight of your animal';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
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
                      controller: _contactNumberController,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number ',
                        hintText: 'Enter contact no. eg : 0772034345',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: _cityController,
                      maxLength: 24,
                      decoration: const InputDecoration(
                        labelText: 'City',
                        hintText:
                            'Enter the city where the animal is located at',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: _addressController,
                      maxLength: 100,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Enter the address of your animal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the address of your animal';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      controller: _descriptionController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter a description of your animal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    MediumButton(
                      color: AppColors.accentYellow,
                      text: 'Create Post',
                      onPressed: _onSubmissionPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
