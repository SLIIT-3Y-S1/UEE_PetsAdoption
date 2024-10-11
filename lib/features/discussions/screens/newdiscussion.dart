import 'package:flutter/material.dart';
import 'discussion_home_screen.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import '../models/discussion.dart';

class NewDiscussionPage extends StatefulWidget {
  const NewDiscussionPage({super.key});

  @override
  State<NewDiscussionPage> createState() => _NewDiscussionPageState();
}

class _NewDiscussionPageState extends State<NewDiscussionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _charCount = 0;
  final int _maxCharCount = 300;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to handle submission
  Future<void> _submitDiscussion() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Create a DiscussionModel instance without userId
    final discussion = DiscussionModel.createDiscussion(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    // Add discussion to Firestore
    await FirestoreService().addDiscussionToFirestore(discussion);

    // Clear the text fields after submission
    _titleController.clear();
    _descriptionController.clear();
    _charCount = 0;

    // Navigate back or show a success message
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DiscussionsHomeScreen()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Discussion added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PawPal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Discussion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter the title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 6,
              maxLength: _maxCharCount,
              onChanged: (text) {
                setState(() {
                  _charCount = text.length;
                });
              },
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a brief description',
                border: const OutlineInputBorder(),
                counterText: '$_charCount/$_maxCharCount',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _submitDiscussion, // Call the submit function
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600], // Matching button color
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the default selected index
        showUnselectedLabels: false, // Hide labels for unselected items
        showSelectedLabels: false, // Hide labels for selected items
        type: BottomNavigationBarType.fixed, // Ensures equal spacing
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/adopt.png',
              width: 32.25, // Updated size
              height: 32.25,
            ),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/discussion.png',
              width: 32.25, // Updated size
              height: 32.25,
            ),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/add.png',
              width: 32.25, // Updated size
              height: 32.25,
            ),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/donation.png',
              width: 32.25, // Updated size
              height: 32.25,
            ),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/vet.png',
              width: 32.25, // Updated size
              height: 32.25,
            ),
            label: '', // Empty label
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to the adopt screen (replace with your screen)
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DiscussionsHomeScreen()),
              );
              break;
            case 2:
              // Navigate to My Discussions Screen
              break;
            case 3:
              // Navigate to the donation screen (replace with your screen)
              break;
            case 4:
              // Navigate to the vet screen (replace with your screen)
              break;
          }
        },
      ),
    );
  }
}
