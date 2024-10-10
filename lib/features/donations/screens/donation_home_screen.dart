import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/screens/donation_form_screen.dart';
// import 'package:pawpal/features/donations/widgets/custom_app_bar.dart';
import 'package:pawpal/features/donations/widgets/custom_bottom_nav.dart';
import 'package:pawpal/features/donations/widgets/donations_home_tab.dart';

class DonationHomeScreen extends StatefulWidget {
  @override
  _DonationHomeScreenState createState() => _DonationHomeScreenState();
}

class _DonationHomeScreenState extends State<DonationHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PawPal'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Donation Requests"),
            Tab(text: "Open Donations"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DonationRequestsTab(), // First tab content
          OpenDonationsTab(), // Second tab content
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DonationFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
