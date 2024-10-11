import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'newdiscussion.dart';
import 'mydiscussions.dart';
import '../models/discussion.dart';
import 'view_discussion.dart';


class DiscussionsHomeScreen extends StatefulWidget {
  const DiscussionsHomeScreen({super.key});

  @override
  State<DiscussionsHomeScreen> createState() => _DiscussionsHomeScreenState();
}

class _DiscussionsHomeScreenState extends State<DiscussionsHomeScreen> {
  List<DiscussionModel> discussions = [];

  bool isDiscussionsPage = true;

  @override
  void initState() {
    super.initState();
    getAllDiscussions();
  }

  Future<void> getAllDiscussions() async {
    try {
      final QuerySnapshot discussionsSnapshot =
          await FirebaseFirestore.instance.collection('discussions').get();

      setState(() {
        discussions = discussionsSnapshot.docs.map((doc) {
          return DiscussionModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      print('Error fetching discussions: $e');
    }
  }

  String timeAgo(DateTime timestamp) {
    final Duration difference = DateTime.now().difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 8),
            const Text(
              'PawPal',
              style: TextStyle(
                fontSize: 20.0,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.yellow,
                      ),
                  ],
                ),
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (!isDiscussionsPage)
                      Container(
                        height: 2.0,
                        width: 100.0,
                        color: Colors.transparent,
                      ),
                  ],
                ),
              ],
            ),
          ),
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
          Expanded(
            child: ListView.builder(
              itemCount: discussions.length,
              itemBuilder: (context, index) {
                final discussion = discussions[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewDiscussionPage(discussion: discussion)
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            discussion.title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            discussion.description.length > 150
                                ? '${discussion.description.substring(0, 150)}...'
                                : discussion.description,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            timeAgo(discussion.timestamp),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {
                                      // Handle like button tap
                                    },
                                  ),
                                  Text('${discussion.noOfLikes}'),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.comment),
                                    onPressed: () {
                                      // Handle comment button tap
                                    },
                                  ),
                                  Text('${discussion.noOfComments}'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/adopt.png',
              width: 32.25,
              height: 32.25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/discussion.png',
              width: 32.25,
              height: 32.25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/add.png',
              width: 32.25,
              height: 32.25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/donation.png',
              width: 32.25,
              height: 32.25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/vet.png',
              width: 32.25,
              height: 32.25,
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              
              break;
            case 1:
              // Already on the discussions screen
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewDiscussionPage()),
              );
              break;
            case 3:
              
              break;
            case 4:
              
              break;
          }
        },
      ),
    );
  }
}
