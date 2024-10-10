import 'package:flutter/material.dart';

// Import the DiscussionsHomeScreen
import 'discussion_home_screen.dart';
import 'newdiscussion.dart';

class MyDiscussionsScreen extends StatefulWidget {
  const MyDiscussionsScreen({super.key});

  @override
  State<MyDiscussionsScreen> createState() => _MyDiscussionsScreenState();
}

class _MyDiscussionsScreenState extends State<MyDiscussionsScreen> {
  // Sample data for discussions
  final List<Map<String, dynamic>> discussions = [
    {
      'title': 'sample title in my discussions ',
      'description': 'sample description in my discussion page',
      'likes': 15500,
      'comments': 568,
      'views': 30200,
      'isFavorite': true,
    },
    {
      'title': 'Best Tricks To Teach A Dog',
      'description': 'What are some of your favorite tricks to teach a dog? Dogs can learn different types of tricks...',
      'likes': 15500,
      'comments': 568,
      'views': 30200,
      'isFavorite': false,
    },
    // Add more discussions here
  ];

  // This variable indicates whether the user is on the 'Discussions' page
  bool isDiscussionsPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // App logo
        title: Row(
          children: [
            // Logo on the left side
            Image.asset(
              'assets/images/logo.png',  // Update with the correct path to your logo image
              height: 50,  // Adjust the size as needed
              width: 50,
            ),
            const SizedBox(width: 8),  // Space between logo and text
            const Text(
              'PawPal',
              style: TextStyle(
                fontSize: 20.0,  // Adjust the font size if needed
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Adding buttons for Discussions and My Discussions with no border
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Discussions Button with yellow line for active page
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isDiscussionsPage = false;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiscussionsHomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Discussions',
                        style: TextStyle(
                          color: Colors.black, // Button text color
                        ),
                      ),
                    ),
                    // Yellow line under Discussions button if it's the active page
                    if (!isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.transparent, // Yellow underline
                      ),
                  ],
                ),
                // My Discussions Button
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isDiscussionsPage = true;
                        });
                      },
                      child: const Text(
                        'My Discussions',
                        style: TextStyle(
                          color: Colors.black, // Button text color
                        ),
                      ),
                    ),
                    // Empty space to align with Discussions underline
                    if (isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.yellow, // No underline for inactive
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Filter and Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle filter action
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by keywords',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tab bar for Most Recent, Popular, and Following
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Most Recent'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Popular'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Following'),
                ),
              ],
            ),
          ),
          // List of discussions
          Expanded(
            child: ListView.builder(
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                final discussion = discussions[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(discussion['title']),
                    subtitle: Text(discussion['description']),
                    trailing: IconButton(
                      icon: Icon(
                        discussion['isFavorite']
                            ? Icons.star
                            : Icons.star_border,
                        color: discussion['isFavorite'] ? Colors.yellow : null,
                      ),
                      onPressed: () {
                        // Handle favorite/unfavorite action
                      },
                    ),
                    isThreeLine: true,
                    leading: Icon(
                      Icons.favorite,
                      color: discussion['isFavorite'] ? Colors.red : Colors.grey,
                    ),
                    onTap: () {
                      // Handle tap on the discussion item
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewDiscussionPage()),
              );
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
