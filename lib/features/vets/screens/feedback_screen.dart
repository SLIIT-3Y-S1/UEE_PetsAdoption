import 'package:flutter/material.dart';

class VetReviewsScreen extends StatefulWidget {
  const VetReviewsScreen({super.key});

  @override
  _VetReviewsScreenState createState() => _VetReviewsScreenState();
}

class _VetReviewsScreenState extends State<VetReviewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample list of reviews with client name, comment, and rating
  List<Map<String, dynamic>> reviews = [
    {
      'name': 'Alice Johnson',
      'comment': 'Great service and friendly vet!',
      'rating': 4.8
    },
    {
      'name': 'Bob Smith',
      'comment': 'The vet was professional and caring.',
      'rating': 4.5
    },
    {
      'name': 'Charlie Brown',
      'comment': 'Not satisfied with the treatment provided.',
      'rating': 2.0
    },
    {
      'name': 'Diana Prince',
      'comment': 'Absolutely loved how well my pet was treated!',
      'rating': 5.0
    },
    {
      'name': 'Eve Adams',
      'comment': 'Very unprofessional. Poor experience.',
      'rating': 1.5
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Filter best and worst reviews
  List<Map<String, dynamic>> getBestReviews() {
    return reviews.where((review) => review['rating'] >= 4.0).toList();
  }

  List<Map<String, dynamic>> getWorstReviews() {
    return reviews.where((review) => review['rating'] < 3.0).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Reviews')),
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Best Reviews'),
            Tab(text: 'Worst Reviews'),
          ],
          indicatorColor: Colors.white,
          labelStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReviewsList(getBestReviews()),
          _buildWorstReviewsTab(),
        ],
      ),
    );
  }

  // Widget to display the list of reviews
  Widget _buildReviewsList(List<Map<String, dynamic>> reviewsList) {
    return reviewsList.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: reviewsList.length,
            itemBuilder: (context, index) {
              final review = reviewsList[index];
              return _buildReviewCard(review);
            },
          )
        : Center(
            child: Text(
              'No reviews available.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
  }

  // Special tab for worst reviews with a message if no bad reviews
  Widget _buildWorstReviewsTab() {
    final worstReviews = getWorstReviews();
    if (worstReviews.isEmpty) {
      return Center(
        child: Text(
          'There is no any worst reviews',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      return _buildReviewsList(worstReviews);
    }
  }

  // Widget for individual review cards
  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client name and rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildStarRating(review['rating']),
              ],
            ),
            const SizedBox(height: 10),
            // Comment
            Text(
              review['comment'],
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display stars and rating number
  Widget _buildStarRating(double rating) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 5),
        Text(
          rating.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
