import 'package:flutter/material.dart';

//import mydiscussion page
import 'newdiscussion.dart';
import 'mydiscussions.dart';

class DiscussionsHomeScreen extends StatefulWidget {
  const DiscussionsHomeScreen({super.key});

  @override
  State<DiscussionsHomeScreen> createState() => _DiscussionsHomeScreenState();
}

class _DiscussionsHomeScreenState extends State<DiscussionsHomeScreen> {
  // Sample data for discussions
  final List<Map<String, dynamic>> discussions = [
    {
      'title': 'Best Tricks To Teach A Dog',
      'description': 'What are some of your favorite tricks to teach a dog? Dogs can learn different types of tricks...',
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
                          isDiscussionsPage = true;
                        });
                      },
                      child: const Text(
                        'Discussions',
                        style: TextStyle(
                          color: Colors.black, // Button text color
                        ),
                      ),
                    ),
                    // Yellow line under Discussions button if it's the active page
                    if (isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.yellow, // Yellow underline
                      ),
                  ],
                ),
                // My Discussions Button
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isDiscussionsPage = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyDiscussionsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'My Discussions',
                        style: TextStyle(
                          color: Colors.black, // Button text color
                        ),
                      ),
                    ),
                    // Empty space to align with Discussions underline
                    if (!isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.transparent, // No underline for inactive
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Added padding inside the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title of the discussion
                        Text(
                          discussion['title'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8), // Space between title and description
                        // Description of the discussion
                        Text(
                          discussion['description'],
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16), // Space between description and buttons
                        // Like, Comment, and Favorite Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Likes and comments section
                            Row(
                              children: [
                                // Like button and count
                                IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  onPressed: () {
                                    // Handle like button tap
                                  },
                                ),
                                Text('${discussion['likes']}'),
                                const SizedBox(width: 16),
                                // Comment button and count
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  onPressed: () {
                                    // Handle comment button tap
                                  },
                                ),
                                Text('${discussion['comments']}'),
                              ],
                            ),
                            // Favorite button on the right side
                            IconButton(
                              icon: Icon(
                                discussion['isFavorite']
                                    ? Icons.star
                                    : Icons.star_border,
                                color: discussion['isFavorite']
                                    ? Colors.yellow
                                    : null,
                              ),
                              onPressed: () {
                                // Handle favorite button tap
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
              // Navigate to the discussions screen (replace with your screen)
              break;
            case 2:
              // Navigate to My Discussions Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewDiscussionPage(),
                ),
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
