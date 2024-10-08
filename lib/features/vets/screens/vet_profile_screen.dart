

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore_for_file: prefer_const_constructors
class VetProfileScreen extends StatelessWidget {
  const VetProfileScreen({super.key});

  void _showReviewDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();
    double rating = 0;

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
                // Submit the review
                print('Name: ${nameController.text}');
                print('Rating: $rating');
                print('Review: ${reviewController.text}');
                Navigator.of(context).pop(); // Close dialog after submission
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Profile'),
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
                children: const [
                  // Profile Picture
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/vets1.jpg'),
                  ),
                  SizedBox(height: 10),
                  // Vet Name
                  Text(
                    'Dr. John Doe',
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
                      Text('Kampala', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.star, color: Colors.yellow),
                      Text('4.8', style: TextStyle(color: Colors.white)),
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
                children: const [
                  Text(
                    'About Dr. John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dr. John Doe has over 10 years of experience in treating animals and is known for his compassionate care. He specializes in small animals and provides a wide range of services.',
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
                children: const [
                  Text(
                    'Services Provided',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('General Check-up'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Vaccinations'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Surgery'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Emergency Services'),
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
                    height: 220, // Adjust height as needed
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: sampleReviews.length,
                      itemBuilder: (context, index) {
                        final review = sampleReviews[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ReviewCard(review: review),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: sampleReviews.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
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
                        // Navigate to all reviews page
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

// Sample review data class
class Review {
  final String reviewerName;
  final String reviewText;
  final int rating;

  Review({
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
  });
}

// Sample reviews list
final List<Review> sampleReviews = [
  Review(
    reviewerName: 'Jane Smith',
    reviewText:
        'Dr. John was very professional and kind to my dog. Highly recommend!',
    rating: 5,
  ),
  Review(
    reviewerName: 'Alex Johnson',
    reviewText:
        'Great service, Dr. John was helpful in an emergency situation.',
    rating: 4,
  ),
  Review(
    reviewerName: 'Emily Davis',
    reviewText: 'My cat is healthy and happy thanks to Dr. John\'s care.',
    rating: 5,
  ),
  Review(
    reviewerName: 'Michael Brown',
    reviewText: 'Efficient and caring. Dr. John made the visit stress-free.',
    rating: 4,
  ),
  // Add more reviews as needed
];

// Updated ReviewCard for horizontal display
class ReviewCard extends StatelessWidget {
  final Review review;

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
                  review.reviewText,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              // Optionally, add date or other info
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '2 days ago',
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
