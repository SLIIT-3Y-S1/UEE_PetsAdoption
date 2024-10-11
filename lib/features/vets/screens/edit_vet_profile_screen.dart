import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/core/services/storage_service.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_event.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_state.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';

class EditVetProfileScreen extends StatefulWidget {
  const EditVetProfileScreen({super.key});

  @override
  _EditVetProfileScreenState createState() => _EditVetProfileScreenState();
}

class _EditVetProfileScreenState extends State<EditVetProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  List<String> personalDetails = [];
  List<dynamic> services = [];

  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();

  Future<void> _pickImage(String email) async {
    print('Picking Image');
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
    if (_imageFile != null) {
      final File imageFile = File(_imageFile!.path);
      final String? imageUrl =
          await _storageService.uploadVetProfileImage(imageFile, email);
      if (imageUrl != null) {
        _firestoreService.updateVetProfilePic(email, imageUrl);
        print('Image uploaded successfully!');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Assuming you are using Bloc and accessing the vet data from Bloc state
    final vetState = BlocProvider.of<VetAuthBloc>(context).state;

    if (vetState is VetAuthSuccess || vetState is VetRegisterSuccess) {
      // Casting the state to access vet data
      VetModel vet = (vetState as dynamic).vet;

      // Print the vet data in initState
      print("Vet Data on Init:");
      print("Name: ${vet!.fullName}");
      print("Email: ${vet!.email}");
      print("Profile Picture URL: ${vet!.services}");
    }
  }

  void handelSaveBtn(VetModel vet) {
    print(personalDetails);
    print(services);

    _firestoreService.updateVetData(
      email: vet.email,
      fullName: personalDetails[0],
      phone: personalDetails[1],
      clinicLocation: personalDetails[2],
      bio: personalDetails[3],
      services: services,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vet Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          BlocBuilder<VetAuthBloc, VetAuthState>(
            builder: (context, state) {
              if (state is VetAuthSuccess || state is VetRegisterSuccess) {
                VetModel vet = (state as dynamic).vet;
                return IconButton(
                  onPressed: () {
                    handelSaveBtn(vet);
                    print('Profile Saved!');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Profile Updated Successfully!')),
                    );
                  },
                  icon: const Icon(Icons.save),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<VetAuthBloc, VetAuthState>(
        builder: (context, state) {
          if (state is VetAuthLoading || state is VetRegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VetAuthSuccess || state is VetRegisterSuccess) {
            final VetModel vet = (state as dynamic).vet;
            personalDetails = [
              vet.fullName,
              vet.phone,
              vet.clinicLocation,
              vet.bio,
            ];
            services = vet.services.cast<String>();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(vet),
                  const SizedBox(height: 20),
                  _buildPersonalDetailsCard(),
                  const SizedBox(height: 20),
                  _buildServicesSection(),
                  const SizedBox(height: 20),
                  _buildAvailabilitySection(),
                ],
              ),
            );
          } else if (state is VetAuthFailure || state is VetRegisterFailure) {
            final errorMessage = state is VetAuthFailure
                ? (state).error
                : (state as VetRegisterFailure).error;

            return Center(child: Text('Error: $errorMessage'));
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  // Profile Section with image upload
  Widget _buildProfileSection(VetModel vet) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile == null
                    ? Image.network(vet.profilePicUrl).image
                    : FileImage(File(_imageFile!.path)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () => _pickImage(vet.email),
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Dr. ${vet.fullName}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'Veterinary Doctor',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Card with Personal Details
  Widget _buildPersonalDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...personalDetails.map((detail) {
              return ListTile(
                title: Text(detail),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _editPersonalDetailsPopup(context, detail);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Services Section with add/edit functionality
  Widget _buildServicesSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Services Provided',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    _addServiceDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: services.map((service) {
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(service),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editServiceDialog(context, service);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            services.remove(service);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Availability Section with toggles
  Widget _buildAvailabilitySection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Availability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Available for Emergency Services'),
              value: true,
              onChanged: (bool value) {
                setState(() {});
              },
            ),
            SwitchListTile(
              title: const Text('Available for Home Visits'),
              value: false,
              onChanged: (bool value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  // Add Service Dialog
  void _addServiceDialog(BuildContext context) {
    final TextEditingController serviceController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Service'),
          content: TextField(
            controller: serviceController,
            decoration: InputDecoration(hintText: 'Enter service name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  services.add(serviceController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Edit Service Dialog
  void _editServiceDialog(BuildContext context, String currentService) {
    final TextEditingController serviceController =
        TextEditingController(text: currentService);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Service'),
          content: TextField(
            controller: serviceController,
            decoration: InputDecoration(hintText: 'Enter service name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int index = services.indexOf(currentService);
                  if (index != -1) {
                    // services[index] = serviceController.text;
                    services[index] = serviceController.text;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Edit Personal Details Popup
  void _editPersonalDetailsPopup(BuildContext context, String currentDetail) {
    final TextEditingController detailsController =
        TextEditingController(text: currentDetail);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Info'),
          content: TextField(
            controller: detailsController,
            decoration: const InputDecoration(hintText: 'Enter Here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  int index = personalDetails.indexOf(currentDetail);
                  if (index != -1) {
                    // Update the personalDetails list
                    personalDetails[index] = detailsController.text;
                    // Dispatch event to Bloc with the updated details
                    BlocProvider.of<VetAuthBloc>(context).add(
                      UpdateVetDetails(personalDetails),
                    );
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
