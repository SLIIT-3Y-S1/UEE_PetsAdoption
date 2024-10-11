import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:pawpal/features/donations/screens/donation_home_screen.dart';
import 'dart:io';

import 'package:pawpal/features/donations/services/donation_service.dart'; // For File class

class DonationRequestForm extends StatefulWidget {
  @override
  _DonationRequestFormState createState() => _DonationRequestFormState();
}

class _DonationRequestFormState extends State<DonationRequestForm> {
  final DonationService donationService = DonationService();

  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _category;
  String? _description;
  bool _isUrgent = false;
  String? _contact;
  String? _location;
  List<XFile>? _images = [];

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title input field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value,
              ),

              // Donation Category dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Donation Category',
                ),
                items: ['Food', 'Clothes', 'Toys', 'Other']
                    .map((category) => DropdownMenuItem(
                          child: Text(category),
                          value: category,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),

              // Description input field
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText:
                      'Enter a brief description about the donation request',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value,
              ),

              // Add Images section
              SizedBox(height: 10),
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
                                child: Icon(
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

              // Urgency checkbox
              Row(
                children: [
                  Text("Is this request urgent?"),
                  Checkbox(
                    value: _isUrgent,
                    onChanged: (value) {
                      setState(() {
                        _isUrgent = value!;
                      });
                    },
                  ),
                ],
              ),

              // Contact input field
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact',
                  hintText: 'Enter a contact number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
                onSaved: (value) => _contact = value,
              ),

              // Location input field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter your location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) => _location = value,
              ),

              // Post button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Perform submission or further processing
                    print("Title: $_title");
                    print("Category: $_category");
                    print("Description: $_description");
                    print("Urgent: $_isUrgent");
                    print("Contact: $_contact");
                    print("Location: $_location");
                    print("Images: ${_images!.length}");
                  }

                  // donationService.addDonation(
                  //     _title, _description, _category, _contact, _location);

                  donationService.addDonation(
                      _title, _description, _category, _contact, _location);

                  print("Added donation request");
                  // donationService.generateCode();
                  // navigate to the home screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => DonationHomeScreen()),
                  );
                },
                child: Text('POST'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: DonationRequestForm(),
    ));
