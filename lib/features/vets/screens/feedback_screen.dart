import 'package:flutter/material.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/vets/models/reviewModel.dart';

class VetReviewsScreen extends StatefulWidget {
  final String vetEmail;
  const VetReviewsScreen({super.key, required this.vetEmail});

  @override
  _VetReviewsScreenState createState() => _VetReviewsScreenState();
}

class _VetReviewsScreenState extends State<VetReviewsScreen>
    with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  late TabController _tabController;

  // Sample list of reviews with client name, comment, and rating
  List<ReviewModel> reviews = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchReviews();
  }

  void _fetchReviews() async {
    List<ReviewModel> fetchedReviews =
        await _firestoreService.fetchReviewsForVet(widget.vetEmail);
    setState(() {
      reviews = fetchedReviews;
    });
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
          _buildReviewsList(reviews),
          _buildWorstReviewsTab(),
        ],
      ),
    );
  }

  // Widget to display the list of reviews
  Widget _buildReviewsList(List<ReviewModel> reviewsList) {
    return reviewsList.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: reviewsList.length,
            itemBuilder: (context, index) {
              final review = reviewsList[index];
              return _buildReviewCard(review);
            },
          )
        : const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          );
  }

  // Special tab for worst reviews with a message if no bad reviews
  Widget _buildWorstReviewsTab() {
    final worstReviews =
        reviews.where((review) => review.rating < 3.0).toList();
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
  Widget _buildReviewCard(ReviewModel review) {
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
                  review.reviewerName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildStarRating(review.rating),
              ],
            ),
            const SizedBox(height: 10),
            // Comment
            Text(
              review.comment,
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
