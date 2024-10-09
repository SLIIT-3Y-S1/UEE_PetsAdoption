import 'package:flutter/material.dart';
// import 'package:pawpal/features/donations/widgets/custom_app_bar.dart';
import 'package:pawpal/features/donations/widgets/custom_bottom_nav.dart';
import 'package:pawpal/features/donations/widgets/donation_form_tab.dart';
import 'package:pawpal/features/donations/widgets/donations_home_tab.dart';

class DonationFormScreen extends StatefulWidget {
  @override
  _DonationFormScreenState createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen>
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
          DonationFormRequestsTab(), // First tab content
          OpenDonationsFormTab(), // Second tab content
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
