import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/theme/theme.dart';
import 'package:pawpal/widgets/common/small_button.dart';

class AdoptionHomeTab extends StatefulWidget {
  @override
  _AdoptionHomeTabState createState() => _AdoptionHomeTabState();
}

class _AdoptionHomeTabState extends State<AdoptionHomeTab> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SmallButton(
                color: AppColors.accentYellow,
                text: 'Filter',
                icon: Icons.filter_alt_outlined,
                onPressed: () {}),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search By Keywords',
                    suffixIcon: Icon(Icons.search),
                  ).applyDefaults(Theme.of(context).inputDecorationTheme),
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                  onSubmitted: (value) {
                    // Handle search
                  },
                  textInputAction: TextInputAction.search,
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 10.0, // Space between tabs
              children: [
                _buildTabButton(context, 'Tab 1', 0),
                _buildTabButton(context, 'Tab 2', 1),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding here
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        ),
        onPressed: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Text(title),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return Text('Content for Tab 1');
      case 1:
        return Text('Content for Tab 2');
      default:
        return Text('Unknown Tab');
    }
  }
}
