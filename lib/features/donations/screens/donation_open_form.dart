import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // For Uint8List
import 'dart:io'; // For File (not used on web)
import 'package:firebase_storage/firebase_storage.dart'; // For file storage
import 'package:path/path.dart'; // For file paths
import 'package:pawpal/features/donations/service/donation_service.dart';

import 'donation_home_screen.dart';

class OpenDonationForm extends StatefulWidget {
  @override
  _OpenDonationFormState createState() => _OpenDonationFormState();
}

class _OpenDonationFormState extends State<OpenDonationForm> {
  final DonationService donationService = DonationService();
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _category;
  String? _description;
  bool _isAvailable = true;
  String? _contact;
  String? _location;
  List<Uint8List?> _imageBytes = []; // For web
  List<File> _images = []; // For mobile

  final ImagePicker _picker = ImagePicker();

  // Function to pick images
  // Function to pick images with specific formats
  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      List<XFile> filteredFiles = [];

      // Filter only jpg, jpeg, png files
      for (var file in pickedFiles) {
        if (kIsWeb) {
          // For web, you can filter based on mime type
          if (file.mimeType == 'image/jpeg' || file.mimeType == 'image/png') {
            filteredFiles.add(file);
          }
        } else {
          // For mobile, you can filter based on file extension
          String fileExtension = file.path.split('.').last.toLowerCase();
          if (fileExtension == 'jpg' ||
              fileExtension == 'jpeg' ||
              fileExtension == 'png') {
            filteredFiles.add(file);
          }
        }
      }

      if (filteredFiles.isNotEmpty) {
        if (kIsWeb) {
          // Web: Use Uint8List for memory images
          List<Uint8List?> bytesList = await Future.wait(
              filteredFiles.map((file) => file.readAsBytes()));
          setState(() {
            _imageBytes.addAll(bytesList);
          });
        } else {
          // Mobile: Use File
          setState(() {
            _images
                .addAll(filteredFiles.map((file) => File(file.path)).toList());
          });
        }
      } else {
        // No valid images selected
        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(
              content: Text('Please select JPEG, JPG, or PNG images only.')),
        );
      }
    }
  }

  // Function to upload image to Firebase Storage
  // Function to upload image to Firebase Storage with proper MIME type
  Future<String?> _uploadImage(dynamic image) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('openDonations/${DateTime.now().millisecondsSinceEpoch}');

      UploadTask uploadTask;
      SettableMetadata metadata;

      if (kIsWeb) {
        // Web: Detect MIME type by checking bytes and set it for the upload
        String mimeType = 'image/jpeg'; // Default to JPEG
        if ((image as Uint8List).toString().contains('PNG')) {
          mimeType = 'image/png';
        }
        metadata = SettableMetadata(contentType: mimeType);
        uploadTask = storageReference.putData(image as Uint8List, metadata);
      } else {
        // Mobile: Use file extension to set the correct MIME type
        String fileExtension =
            basename(image.path).split('.').last.toLowerCase();
        String mimeType = (fileExtension == 'png') ? 'image/png' : 'image/jpeg';
        metadata = SettableMetadata(contentType: mimeType);
        uploadTask = storageReference.putFile(image as File, metadata);
      }

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Uploaded image URL: $downloadUrl'); // Debug print
      return downloadUrl;
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }

  // Submit the donation form
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      List<String> imageUrls = [];

      // Upload images and get their URLs
      for (var image in kIsWeb ? _imageBytes : _images) {
        if (image != null) {
          String? url = await _uploadImage(image);
          if (url != null) {
            imageUrls.add(url);
          }
        }
      }

      // print(imageUrls);
      // Add donation details to Firestore
      donationService.addOpenDonation(
        _title,
        _description,
        _category,
        _contact,
        _location,
        _isAvailable,
        imageUrls,
      );

      // Navigate to Donation Home Screen
      Navigator.of(this.context).pushReplacement(
        MaterialPageRoute(builder: (context) => DonationHomeScreen()),
      );
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
                  // Display images
                  if (kIsWeb)
                    ..._imageBytes.map((image) {
                      if (image != null) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.memory(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Container();
                    }).toList(),
                  if (!kIsWeb)
                    ..._images.map((image) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.file(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )),
                  // Add more button
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: _pickImages,
                  ),
                ],
              ),

              // Urgency checkbox
              Row(
                children: [
                  Text("Is this available?"),
                  Checkbox(
                    value: _isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value!;
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
                onPressed: _submitForm,
                child: Text('POST'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
