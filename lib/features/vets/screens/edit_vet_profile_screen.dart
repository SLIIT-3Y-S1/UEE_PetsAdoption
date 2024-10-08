import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditVetProfileScreen extends StatefulWidget {
  const EditVetProfileScreen({super.key});

  @override
  _EditVetProfileScreenState createState() => _EditVetProfileScreenState();
}

class _EditVetProfileScreenState extends State<EditVetProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  List<String> services = ['General Check-up', 'Vaccinations', 'Surgery'];
  List<String> personalDetails = [
    'Dr. Mash',
    '0716514923',
    'Malabe',
    'Bio here, this is my bio details'
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vet Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('Profile Saved!');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile Updated Successfully!')),
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            _buildPersonalDetailsCard(),
            const SizedBox(height: 20),
            _buildServicesSection(),
            const SizedBox(height: 20),
            _buildAvailabilitySection(),
          ],
        ),
      ),
    );
  }

  // Profile Section with image upload
  Widget _buildProfileSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile == null
                    ? AssetImage('assets/images/vets1.jpg') as ImageProvider
                    : FileImage(File(_imageFile!.path)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: _pickImage,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Dr. Mash',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            Text(
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
                Text(
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
          title: Text('Edit Info'),
          content: TextField(
            controller: detailsController,
            decoration: InputDecoration(hintText: 'Enter Here'),
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
                  int index = personalDetails.indexOf(currentDetail);
                  if (index != -1) {
                    personalDetails[index] = detailsController.text;
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
}
