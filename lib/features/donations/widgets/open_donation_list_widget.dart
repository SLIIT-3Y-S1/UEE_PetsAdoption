import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawpal/features/donations/services/donation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/models/user_model.dart';

class OpenDonationsList extends StatelessWidget {
  final DonationService donationService = DonationService();

  String? _email;
  void _fetchUserEmail(BuildContext context) {
    final state = BlocProvider.of<UserAuthBloc>(context).state;
    if (state is UserAuthLoading) {
      // Handle loading state if needed
    } else if (state is UserAuthSuccess) {
      UserModel user = state.user;
      print('Logged in as: ${user.username}');
      _email = user.email; // Set _name to user.firstName
    } else if (state is UserAuthFailure) {
      // Handle error state if needed
      print('Error: ${state.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserEmail(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('openDonations')
          .where('contact', isEqualTo: _email)
          .snapshots(),
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
            return Card(
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
                          return Icon(Icons.broken_image); // Error placeholder
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
                    Text(donation['location'] ?? 'No location'),
                    Text(
                      donation['isAvailable'] == true
                          ? 'Available'
                          : 'Not Available',
                      style: TextStyle(
                        color: donation['isAvailable'] == true
                            ? Colors.green
                            : Colors.red,
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
            );
          },
        );
      },
    );
  }

  // Format timestamp to a readable date string
  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
