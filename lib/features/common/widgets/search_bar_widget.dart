import 'package:flutter/material.dart';

class SearchBarWithFilterWidget extends StatefulWidget {
  final VoidCallback _showFilterBottomSheet;
  final TextEditingController _searchController;

  const SearchBarWithFilterWidget({
    super.key,
    required VoidCallback showFilterBottomSheet,
    required TextEditingController searchController,
  })  : _showFilterBottomSheet = showFilterBottomSheet,
        _searchController = searchController;

  @override
  State<SearchBarWithFilterWidget> createState() =>
      _SearchBarWithFilterWidgetState();
}

class _SearchBarWithFilterWidgetState extends State<SearchBarWithFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget._searchController,
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
              onPressed: widget._showFilterBottomSheet, // Open filter modal
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
