import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

import 'package:pawpal/core/widgets/vets_widgets/vet_card.dart';

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
class AllVetsTab extends StatelessWidget {
  const AllVetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return const VetCard(); // Reuse your VetCard widget
      },
    );
  }
}

// Second Tab Content (Top Rated Vets)
class TopRatedVetsTab extends StatelessWidget {
  const TopRatedVetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return const VetCard(); // Same VetCard, but you can filter for top-rated vets
      },
    );
  }
}
