import 'package:flutter/material.dart';
import 'discussion_home_screen.dart';
import 'package:pawpal/features/discussions/services/discussion_services.dart';
import '../models/discussion.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import the Bloc package
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart'; // Import your User Bloc
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart'; // Import states

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

    // Retrieve email from the UserAuthBloc
    final userState = context.read<UserAuthBloc>().state;
    String? userEmail;

    if (userState is UserAuthSuccess) {
      userEmail = userState.user.email; // Fetch the email from the user state
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    // Create a DiscussionModel instance with email
    final discussion = DiscussionModel.createDiscussion(
      title: _titleController.text,
      description: _descriptionController.text,
      email: userEmail, // Pass the email from the authenticated user
    );

    // Add discussion to Firestore
    try {
      await FirestoreService().addDiscussionToFirestore(discussion);

      // Clear the text fields after submission
      _titleController.clear();
      _descriptionController.clear();
      _charCount = 0;

      // Navigate back to the discussions page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DiscussionsHomeScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Discussion added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add discussion: $e')),
      );
    }
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
      
    );
  }
}
