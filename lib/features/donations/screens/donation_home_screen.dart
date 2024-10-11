import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/donations/screens/donation_form_screen.dart';
import 'package:pawpal/features/donations/widgets/donations_home_tab.dart';

class DonationHomeScreen extends StatefulWidget {
  @override
  _DonationHomeScreenState createState() => _DonationHomeScreenState();
}

class _DonationHomeScreenState extends State<DonationHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Sample data for both tabs
  final List<Map<String, dynamic>> requestDonation = [];
  final List<Map<String, dynamic>> openDonation = [];
  List<Map<String, dynamic>> filteredRequestDonation = [];
  List<Map<String, dynamic>> filteredOpenDonation = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Most Recent';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Initially, filtered lists are the same as the original lists
    filteredRequestDonation = List.from(requestDonation);
    filteredOpenDonation = List.from(openDonation);

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Method to handle changes in the search bar
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRequestDonation = requestDonation
          .where((donation) =>
              donation['title'].toLowerCase().contains(query) ||
              donation['description'].toLowerCase().contains(query))
          .toList();

      filteredOpenDonation = openDonation
          .where((donation) =>
              donation['title'].toLowerCase().contains(query) ||
              donation['description'].toLowerCase().contains(query))
          .toList();
    });
  }

// Method to show filter bottom sheet
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Discussions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Most Recent'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Most Recent';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Most Recent'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
              ListTile(
                title: const Text('Popular'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Popular';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Popular'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
              ListTile(
                title: const Text('Following'),
                onTap: () {
                  setState(() {
                    _selectedFilter = 'Following';
                  });
                  Navigator.pop(context);
                },
                trailing: _selectedFilter == 'Following'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by keywords...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _showFilterBottomSheet, // Open filter modal
                icon: const Icon(Icons.filter_list),
                label: const Text('Filter'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Request Donations'),
              Tab(text: 'Open Donations'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [DonationRequestsTab(), OpenDonationsTab()],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationFormScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
