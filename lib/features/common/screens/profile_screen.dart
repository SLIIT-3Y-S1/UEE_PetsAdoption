import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_event.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/features/common/screens/splash_screen.dart';
import 'package:pawpal/features/donations/widgets/donation_requests_list_widget.dart';
import 'package:pawpal/features/donations/widgets/open_donation_list_widget.dart';
import 'package:pawpal/features/common/widgets/profile_appbar.dart';
import 'package:pawpal/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  String? _name;
  void _fetchUserName(BuildContext context) {
    final state = BlocProvider.of<UserAuthBloc>(context).state;
    if (state is UserAuthLoading) {
      // Handle loading state if needed
    } else if (state is UserAuthSuccess) {
      UserModel user = state.user;
      print('Logged in as: ${user.username}');
      _name = user.firstName; // Set _name to user.firstName
    } else if (state is UserAuthFailure) {
      // Handle error state if needed
      print('Error: ${state.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserName(context);

    return DefaultTabController(
      length: 3, // Number of main tabs
      child: Scaffold(
        appBar: ProfileAppbar(),
        body: Column(
          children: [
            // User Profile Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage('assets/images/user-avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  // User Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Veterinarian and dog lover',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  // Spacer(),
                  // Share and Edit Profile buttons
                  // IconButton(
                  //   icon: Icon(Icons.share),
                  //   onPressed: () {},
                  // ),
                  // logout button
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      BlocProvider.of<UserAuthBloc>(context)
                          .add((UserAuthLogoutRequested()));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    },
                  ),
                ],
              ),
            ),
            // Main Tabs: Posts, Donations, Discussions
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Donations'),
                Tab(text: 'Discussions'),
              ],
            ),
            // TabBarView for the content of each main tab
            Expanded(
              child: TabBarView(
                children: [
                  // Posts Tab
                  Center(child: Text('Posts Section')),
                  // Donations Tab (with internal state management)
                  DonationsTab(),
                  // Discussions Tab
                  Center(child: Text('Discussions Section')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Donations Tab Content with internal state management for subtabs
class DonationsTab extends StatefulWidget {
  @override
  _DonationsTabState createState() => _DonationsTabState();
}

class _DonationsTabState extends State<DonationsTab> {
  int selectedIndex = 0; // Default to "Donation Requests"

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sub Tabs for "Donation Requests" and "Open Donations"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0; // Show Donation Requests
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Donation Requests',
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1; // Show Open Donations
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
                child:
                    // In here I want do show DonationRecord() widget
                    Text(
                  'Open Donations',
                  style: TextStyle(
                    color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Display content based on selectedIndex
        Expanded(
          child:
              selectedIndex == 0 ? DonationRequestsList() : OpenDonationsList(),
        ),
      ],
    );
  }
}
