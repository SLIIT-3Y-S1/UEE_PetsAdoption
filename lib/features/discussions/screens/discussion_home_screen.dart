import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'newdiscussion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_discussion.dart';
import '../models/discussion.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import the Bloc package
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart'; // Import your User Bloc
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart'; // Import states

class DiscussionsHomeScreen extends StatefulWidget {
  const DiscussionsHomeScreen({super.key});

  @override
  State<DiscussionsHomeScreen> createState() => _DiscussionsHomeScreenState();
}

class _DiscussionsHomeScreenState extends State<DiscussionsHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<DiscussionModel> discussions = [];
  List<DiscussionModel> filteredDiscussions = [];
  List<DiscussionModel> myDiscussions = []; // List for my discussions
  String _selectedFilter = 'Most Recent'; // Default filter
  String? userEmail; // Variable to store user email

  // Add a list to track liked discussions
  List<bool> likedDiscussions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
    getAllDiscussions();
    _retrieveUserEmail(); // Retrieve user email
  }

  Future<void> getAllDiscussions() async {
    try {
      final QuerySnapshot discussionsSnapshot = await FirebaseFirestore.instance
          .collection('discussions')
          .orderBy('timestamp', descending: true) // Order by createdAt field in descending order
          .get();

      setState(() {
        discussions = discussionsSnapshot.docs.map((doc) {
          return DiscussionModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        filteredDiscussions = List.from(discussions);
        likedDiscussions = List.filled(discussions.length, false); // Initialize liked status
        filterMyDiscussions(); // Filter My Discussions after fetching
      });
    } catch (e) {
      print('Error fetching discussions: $e');
    }
  }

  void _retrieveUserEmail() {
    final userState = context.read<UserAuthBloc>().state;
    if (userState is UserAuthSuccess) {
      userEmail = userState.user.email; 
    }
  }

  void filterMyDiscussions() {
    if (userEmail != null) {
      setState(() {
        myDiscussions = discussions.where((discussion) => discussion.email == userEmail).toList();
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDiscussions = discussions
          .where((discussion) =>
              discussion.title.toLowerCase().contains(query) ||
              discussion.description.toLowerCase().contains(query))
          .toList();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Discussions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Most Recent'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Most Recent';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Most Recent'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
              ListTile(
                title: const Text('Popular'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Popular';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Popular'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
              ListTile(
                title: const Text('Following'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Following';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Following'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Function to calculate time ago
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

  // Function to handle like button tap
  void _handleLikeButton(int index) {
    setState(() {
      likedDiscussions[index] = !likedDiscussions[index]; // Toggle like status
      discussions[index].noOfLikes = likedDiscussions[index] ? 1 : 0; // Update like count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by keywords...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _showFilterBottomSheet, // Open filter modal
                icon: const Icon(Icons.filter_list),
                label: const Text('Filter'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Discussions'),
              Tab(text: 'My Discussions'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDiscussionsList(filteredDiscussions),
                _buildDiscussionsList(myDiscussions), // My Discussions
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewDiscussionPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDiscussionsList(List<DiscussionModel> data) {
    if (data.isEmpty) {
      return const Center(
        child: Text('No discussions found'),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final discussion = data[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewDiscussionPage(discussion: discussion),
              ),
            );
            getAllDiscussions(); // Refresh when back
          },
          child: Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discussion.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    discussion.description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Display time ago in the bottom right corner
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      timeAgo(discussion.timestamp), // Ensure this returns a DateTime object
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              likedDiscussions[index] 
                                  ? Icons.favorite 
                                  : Icons.favorite_border,
                              color: likedDiscussions[index] 
                                  ? Colors.red // Change color if liked
                                  : null,
                            ),
                            onPressed: () => _handleLikeButton(index), // Handle like
                          ),
                          Text(
                            '${discussion.noOfLikes}', // Show like count
                            style: const TextStyle(fontSize: 14.0),
                          ),
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
    );
  }
}