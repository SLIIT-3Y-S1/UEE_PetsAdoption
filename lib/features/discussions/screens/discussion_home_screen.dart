import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/discussions/newdiscussion.dart';

class DiscussionsHomeScreen extends StatefulWidget {
  const DiscussionsHomeScreen({super.key});

  @override
  State<DiscussionsHomeScreen> createState() => _DiscussionsHomeScreenState();
}

class _DiscussionsHomeScreenState extends State<DiscussionsHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // Sample data for both tabs
  final List<Map<String, dynamic>> discussions = [];
  final List<Map<String, dynamic>> myDiscussions = [];
  List<Map<String, dynamic>> filteredDiscussions = [];
  List<Map<String, dynamic>> filteredMyDiscussions = [];

  String _selectedFilter = 'Most Recent'; // Default filter

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Sample discussions data
    discussions.addAll([
      {
        'title': 'Best Tricks To Teach A Dog',
        'description': 'What are some of your favorite tricks to teach a dog?',
        'likes': 15500,
        'comments': 568,
        'views': 30200,
        'isFavorite': true,
      },
      {
        'title': 'How to Train a Cat',
        'description': 'Cats are independent, but they can be trained too...',
        'likes': 15000,
        'comments': 500,
        'views': 27000,
        'isFavorite': false,
      },
    ]);

    // Sample my discussions data
    myDiscussions.addAll([
      {
        'title': 'My Tips for Pet Training',
        'description': 'I have trained multiple dogs, and here are my tips...',
        'likes': 12000,
        'comments': 400,
        'views': 24000,
        'isFavorite': true,
      },
      {
        'title': 'Feeding Habits for Pets',
        'description': 'Here are some tips for feeding your pets...',
        'likes': 10000,
        'comments': 200,
        'views': 15000,
        'isFavorite': false,
      },
    ]);

    // Initially, filtered lists are the same as the original lists
    filteredDiscussions = List.from(discussions);
    filteredMyDiscussions = List.from(myDiscussions);

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Method to handle changes in the search bar
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredDiscussions = discussions
          .where((discussion) =>
              discussion['title'].toLowerCase().contains(query) ||
              discussion['description'].toLowerCase().contains(query))
          .toList();

      filteredMyDiscussions = myDiscussions
          .where((discussion) =>
              discussion['title'].toLowerCase().contains(query) ||
              discussion['description'].toLowerCase().contains(query))
          .toList();
    });
  }

  // Method to show filter bottom sheet
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
                _buildDiscussionsList(filteredMyDiscussions),
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

  // Method to build the discussions list
  Widget _buildDiscussionsList(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return const Center(
        child: Text('No discussions found'),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final discussion = data[index];
        return Card(
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
                // Title of the discussion
                Text(
                  discussion['title'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Description of the discussion
                Text(
                  discussion['description'],
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
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
                        color: discussion['isFavorite'] ? Colors.yellow : null,
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
    );
  }
}
