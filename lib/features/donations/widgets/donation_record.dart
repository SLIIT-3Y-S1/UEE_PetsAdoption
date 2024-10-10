import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/screens/donation_form_screen.dart';

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
              onTap: () async {
                final donationId = donation.id;
                final donationDetails =
                    await donationService.getDonation(donationId);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        height: 500, // Adjust the height as needed
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/dog_food.jpg', // Your image path
                              height: 150, // Adjust the height as needed
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 16),
                            Text(
                              donationDetails['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(donationDetails['category']),
                            SizedBox(height: 8),
                            Text(
                              donationDetails['location'],
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Description: ${donationDetails['description']}'),
                            SizedBox(height: 8),
                            Text('Contact: ${donationDetails['contact']}'),
                            Spacer(),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DonationFormScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellow[200], // Light yellow color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 32),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                                child: Text('Contact'),
                              ),
                            ),
                            SizedBox(height: 16),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.asset('assets/images/dog_food.jpg',
                      width: 50), // Your image
                  title: Text(
                    donation['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donation['category']),
                      Text(
                        donation['location'],
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Text('Contact: ${donation['contact']}'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
