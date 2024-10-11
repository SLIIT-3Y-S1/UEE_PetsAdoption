import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawpal/features/donations/service/donation_service.dart';

class DonationRecord extends StatelessWidget {
  final DonationService donationService = DonationService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('donations').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No donations found.'));
        }
        final donations = snapshot.data!.docs;
        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
            return GestureDetector(
              onTap: () {
                final donationId = donation.id;
                showDialog(
                  context: context,
                  builder: (context) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: donationService.getDonation(donationId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.hasError) {
                          return Center(
                              child: Text('Error loading donation details.'));
                        }
                        final donationDetails = snapshot.data!;
                        if (donationDetails.data() == null) {
                          return Center(
                              child: Text('No donation details available.'));
                        }
                        final Map<String, dynamic> data =
                            donationDetails.data() as Map<String, dynamic>;

                        // Fetch image URLs
                        final List<String> imageUrls = _getValidImageUrls(data);

                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                height: MediaQuery.of(context).size.height *
                                    0.8, // 80% of screen height
                                width: MediaQuery.of(context).size.width *
                                    0.9, // 90% of screen width
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Swiping images if more than one
                                      imageUrls.isNotEmpty
                                          ? _buildImageSwiper(imageUrls)
                                          : Text('No valid image available'),
                                      SizedBox(height: 16),

                                      // Poster information and clickable user profile
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Handle user profile click
                                              print('User profile clicked');
                                            },
                                            child: Text(
                                              'Posted: @${data['contact'] ?? 'Unknown'}',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // Donation title
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data['title'] ??
                                                'No title available',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          Text(
                                            data['isUrgent'] == true
                                                ? 'Urgent'
                                                : 'Not Urgent',
                                            style: TextStyle(
                                              color: data['isUrgent'] == true
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      // Date and Category
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildDetailItem(
                                              label: 'Date',
                                              value: _formatTimestamp(
                                                  data['timestamp'])),
                                          _buildDetailItem(
                                              label: 'Category',
                                              value: data['category'] ??
                                                  'No category available'),
                                        ],
                                      ),
                                      SizedBox(height: 8),

                                      // Location
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.blue),
                                          Text(
                                            data['location'] ??
                                                'No location available',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18, // Bigger font size
                                              fontWeight:
                                                  FontWeight.bold, // Bold font
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),

                                      // About section
                                      Text('About',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        data['description'] ??
                                            'No description available',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 16),

                                      // Contact information
                                      // Contact button
                                      SizedBox(height: 32),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red, // Background color
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 16),
                                          ),
                                          onPressed: () {
                                            // Handle contact action
                                          },
                                          child: Text(
                                            'Donate',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0.0,
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: donation['images'] != null &&
                          donation['images'].isNotEmpty
                      ? Image.network(
                          donation['images'][0], // Use first image in the list
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading thumbnail: $error');
                            return Icon(
                                Icons.broken_image); // Error placeholder
                          },
                        )
                      : Image.asset(
                          'assets/images/dog_food.jpg', // Placeholder for no image
                          width: 50,
                          height: 50,
                        ),
                  title: Text(
                    donation['title'] ?? 'No title',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donation['category'] ?? 'No category'),
                      Text(
                        donation['location'] ?? 'No location',
                      ),
                      Text(
                        donation['isUrgent'] == true ? 'Urgent' : 'Not Urgent',
                        style: TextStyle(
                          color: donation['isUrgent'] == true
                              ? Colors.red
                              : Colors.green, // Change color for 'Not urgent'
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end, // Align to bottom
                    children: [
                      Text(
                        'Date: ${_formatTimestamp(donation['timestamp'])}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Swiper function to swipe through multiple images
  Widget _buildImageSwiper(List<String> imageUrls) {
    PageController pageController = PageController();
    ValueNotifier<int> currentPage = ValueNotifier<int>(0);

    return Column(
      children: [
        Container(
          height: 200, // Adjust height of image
          width: double.infinity,
          child: PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            onPageChanged: (index) {
              currentPage.value = index; // Update the current page when swiping
            },
            itemBuilder: (context, index) {
              return Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Column(
                    children: [
                      Icon(Icons.broken_image, size: 50),
                      Text('Error loading image'),
                    ],
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 8),
        // Dots indicator for swiping
        ValueListenableBuilder<int>(
          valueListenable: currentPage,
          builder: (context, currentIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageUrls.length,
                (index) => GestureDetector(
                  onTap: () {
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    currentPage.value =
                        index; // Update currentPage to keep it in sync
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Format timestamp to a readable date string
  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // Build detail item widget
  Widget _buildDetailItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  // Temporarily always return true for valid image URLs
  bool _isValidImageUrl(String url) {
    return true; // Implement your validation logic if needed
  }

  // Get the valid image URLs or return an empty list if no valid URLs
  List<String> _getValidImageUrls(Map<String, dynamic> donationDetails) {
    if (donationDetails['images'] != null &&
        donationDetails['images'].isNotEmpty) {
      List<String> imageUrls = List<String>.from(
        donationDetails['images'].where((url) => _isValidImageUrl(url)),
      );
      print('Fetched image URLs: $imageUrls'); // Debug print
      return imageUrls;
    }
    return [];
  }
}
