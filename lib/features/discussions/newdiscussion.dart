import 'package:flutter/material.dart';

class NewDiscussionPage extends StatefulWidget {
  // Added key parameter to the constructor
  const NewDiscussionPage({Key? key}) : super(key: key);

  @override
  State<NewDiscussionPage> createState() => _NewDiscussionPageState();
}

class _NewDiscussionPageState extends State<NewDiscussionPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _charCount = 0;
  final int _maxCharCount = 300;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Discussion'), // Added const
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none), // Added const
            onPressed: () {
              // Notification action here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added const
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration( // Added const
                labelText: 'Title',
                hintText: 'Enter the title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16), // Added const
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
                hintText: 'Enter a brief description about yourself',
                border: const OutlineInputBorder(),
                counterText: '$_charCount/$_maxCharCount', // Dynamic text, no const here
              ),
            ),
            const SizedBox(height: 20), // Added const
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Submission logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600], // Button color
                ),
                child: const Text('Submit'), // Add the child argument here
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[ // Added const for the list of items
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Added const
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message), // Added const
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box), // Added const
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // Added const
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Added const
            label: '',
          ),
        ],
        currentIndex: 1, // Dynamic, no const here
        selectedItemColor: Colors.red, // No const as this is dynamic
        unselectedItemColor: Colors.grey, // No const as this is dynamic
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NewDiscussionPage(), // Added const
  ));
}
