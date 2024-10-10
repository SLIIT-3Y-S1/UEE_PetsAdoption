import 'package:flutter/material.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'dart:ui';

import 'package:pawpal/core/widgets/vets_widgets/vet_card.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';

class VetsListScreen extends StatefulWidget {
  const VetsListScreen({super.key});

  @override
  State<VetsListScreen> createState() => _VetsListScreenState();
}

class _VetsListScreenState extends State<VetsListScreen> {
  void _showSearchBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make background transparent
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(
                top: 100), // Optional: Push modal down a bit
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search vets...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the search bar
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // getReview list
  // void getReview() async {
  //   final FirestoreService _firestoreService = FirestoreService();
  //   List<VetModel> fetchedVets = await _firestoreService.fetchReviewsForVet();
  //   print(fetchedVets);
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Veterinarians'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _showSearchBar(context); // Show search bar with blur effect
              },
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            dividerColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 14),
            tabs: [
              Tab(text: 'All Vets'), // First tab
              Tab(text: 'Top Rated'), // Second tab
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllVetsTab(), // First tab content
            TopRatedVetsTab(), // Second tab content
          ],
        ),
      ),
    );
  }
}

// First Tab Content (All Vets)
class AllVetsTab extends StatefulWidget {
  const AllVetsTab({super.key});

  @override
  State<AllVetsTab> createState() => _AllVetsTabState();
}

class _AllVetsTabState extends State<AllVetsTab> {
  final FirestoreService _firestoreService = FirestoreService();
  late List<VetModel> _vetsList = [];

  @override
  void initState() {
    super.initState();
    _fetchVets(); // Fetch the vet list when the state is initialized
  }

  // Separate async method to fetch the vets list
  Future<void> _fetchVets() async {
    List<VetModel> fetchedVets = await _firestoreService.getVetList();
    print(fetchedVets);
    setState(() {
      _vetsList = fetchedVets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _vetsList.isEmpty
        ? const Center(
            child:
                CircularProgressIndicator()) // Show a loader while the list is loading
        : ListView.builder(
            itemCount: _vetsList.length,
            itemBuilder: (context, index) {
              return VetCard(
                  vetModel: _vetsList[
                      index]); // Pass the current vet to the VetCard widget
            },
          );
  }
}

// Second Tab Content (Top Rated Vets)
class TopRatedVetsTab extends StatefulWidget {
  const TopRatedVetsTab({super.key});

  @override
  State<TopRatedVetsTab> createState() => _TopRatedVetsTabState();
}

class _TopRatedVetsTabState extends State<TopRatedVetsTab> {
  final FirestoreService _firestoreService = FirestoreService();
  List<VetModel> _topRatedVets = [];
  @override
  void initState() {
    filterTopRatedVets();
    super.initState();
  }

  // filter top rated vets
  void filterTopRatedVets() async {
    _topRatedVets = await _firestoreService.fetchTopRatedVets();
    setState(() {});
  }
  // print(fetchedVets);

  @override
  Widget build(BuildContext context) {
    return _topRatedVets.isEmpty
        ? const Center(
            child:
                CircularProgressIndicator()) // Show a loader while the list is loading
        : ListView.builder(
            itemCount: _topRatedVets.length,
            itemBuilder: (context, index) {
              return VetCard(
                vetModel: _topRatedVets[index],
              ); // Same VetCard, but you can filter for top-rated vets
            },
          );
  }
}
