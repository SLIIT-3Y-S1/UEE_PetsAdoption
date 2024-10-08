import 'package:flutter/material.dart';
import 'package:pawpal/features/vets/screens/msg_one_screen.dart';

// Messages List Screen
class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chats')),
        backgroundColor: Colors.teal,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search action
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 10, // Sample count, replace with actual data
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/user-avatar.png'),
            ),
            title: const Text('Contact Name'),
            subtitle: const Text('Last message preview goes here...'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '12:30 PM',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            onTap: () {
              // Navigate to message screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessageScreen(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new chat action
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.message),
      ),
    );
  }
}
