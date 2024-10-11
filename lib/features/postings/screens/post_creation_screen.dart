import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/donations/widgets/donation_form_tab.dart';
import 'package:pawpal/features/postings/screens/adoption/adoption_post_creation.dart';
import 'package:pawpal/theme/theme.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  _PostCreationScreen createState() => _PostCreationScreen();
}

class _PostCreationScreen extends State<PostCreationScreen> {
  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: AppTheme.lightTheme.textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select the type of post you are making:',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _onButtonPressed(0),
                child: Text('Adoption Post', style: AppTheme.lightTheme.textTheme.bodyMedium,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedIndex == 0 ? AppColors.accentYellow : const Color.fromARGB(255, 255, 255, 255),
                  foregroundColor: _selectedIndex == 0 ? Colors.black : Colors.black,
                  elevation: 0.0,
                ),
              ),
              
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _onButtonPressed(1),
                child: Text('Lost Pet Post', style:AppTheme.lightTheme.textTheme.bodyMedium,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedIndex == 1 ? AppColors.accentRed : const Color.fromARGB(255, 255, 255, 255),
                  foregroundColor: _selectedIndex == 1 ? Colors.black : Colors.black,
                  elevation: 0.0
                ),
              ),
              const SizedBox(height:20),
            ],
          ),
          Expanded(
            child: _selectedIndex == 0
                ?AdoptionPostCreation() // First tab content
                : DonationFormRequestsTab(), // Second tab content
          ),
        ],
      ),
    );
  }
}
