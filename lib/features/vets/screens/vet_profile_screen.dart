import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/vets/models/reviewModel.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore_for_file: prefer_const_constructors
class VetProfileScreen extends StatefulWidget {
  final VetModel vetModel;

  const VetProfileScreen({super.key, required this.vetModel});

  @override
  State<VetProfileScreen> createState() => _VetProfileScreenState();
}

class _VetProfileScreenState extends State<VetProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  List<ReviewModel> reviewsList = [];

  initState() {
    super.initState();
    _getReviews();
  }

  void _getReviews() async {
    reviewsList =
        await _firestoreService.fetchReviewsForVet(widget.vetModel.email);
    setState(() {});
  }

  double rating = 0;
  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text('Submit Review'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Input
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                // Rating Input
                const Text('Rating'),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    rating = newRating;
                  },
                ),
                const SizedBox(height: 10),
                // Review Input
                TextFormField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Your Review',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveReview();
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _saveReview() async {
    // Save review to Firestore
    ReviewModel review = ReviewModel(
      reviewerName: nameController.text,
      rating: rating,
      comment: reviewController.text,
      date: DateTime.now(),
    );

    await _firestoreService.addReviewToFirestore(widget.vetModel.email, review);
    reviewsList.add(review);
    //calculate average rating
    final double agvRating = calculateRating();

    // Update vet's rating
    await _firestoreService.updateRatingForVet(
        widget.vetModel.email, agvRating);
    Navigator.of(context).pop(); // Close dialog after submission
  }

  double calculateRating() {
    double totalRating = 0;
    if (reviewsList.isEmpty) {
      return 0;
    }
    for (var review in reviewsList) {
      totalRating += review.rating;
    }
    var ratingString = (totalRating / reviewsList.length).toStringAsFixed(1);
    return double.parse(ratingString);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vetModel.fullName),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.blueAccent,
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage(widget.vetModel.profilePicUrl),
                  ),
                  SizedBox(height: 10),
                  // Vet Name
                  Text(
                    'Dr. ${widget.vetModel.fullName}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Specialization
                  Text(
                    'Veterinary Surgeon',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Location and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      Text(widget.vetModel.clinicLocation,
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.star, color: Colors.yellow),
                      Text('${widget.vetModel.rating}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Bio Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Dr. ${widget.vetModel.fullName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.vetModel.bio,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services Provided',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.vetModel.services.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.vetModel.services[index]),
                        leading: Icon(Icons.check_circle, color: Colors.green),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Contact Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Call functionality
                      },
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text(
                        'Call',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Message functionality
                      },
                      icon: const Icon(Icons.message, color: Colors.white),
                      label: const Text('Message',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: reviewsList.isEmpty
                        ? 50
                        : 220, // Adjust height as needed
                    child: reviewsList.isEmpty
                        ? Center(
                            child: Text('No reviews yet.'),
                          )
                        : PageView.builder(
                            controller: pageController,
                            itemCount: reviewsList.length,
                            itemBuilder: (context, index) {
                              return ReviewCard(review: reviewsList[index]);
                            },
                          ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: reviewsList.isEmpty
                        ? Container()
                        : SmoothPageIndicator(
                            controller: pageController,
                            count: reviewsList.length,
                            effect: WormEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              activeDotColor: Colors.blueAccent,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        _showReviewDialog(context);
                      },
                      child: const Text('Add a Review'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Updated ReviewCard for horizontal display
class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Fixed width for horizontal scrolling
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reviewer Name and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.reviewerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < review.rating ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Review Text
              Expanded(
                child: Text(
                  review.comment,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              // Optionally, add date or other info
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${review.date}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
