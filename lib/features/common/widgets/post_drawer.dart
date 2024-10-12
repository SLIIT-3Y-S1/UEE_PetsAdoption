import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/features/discussions/newdiscussion.dart';
import 'package:pawpal/features/donations/screens/donation_form_screen.dart';
import 'package:pawpal/theme/theme.dart';

class PostDrawer extends StatelessWidget {
  const PostDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: BottomNavigationBar(
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppVectors.newpost),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppVectors.newdiscuss),
            label: 'Discuss',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppVectors.newdonation),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppVectors.newrequest),
            label: 'Request',
          ),
        ],
        onTap: (index) {
          // Handle tap based on index
          switch (index) {
            case 0:
              // Handle New Post tap
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewDiscussionPage()));
              break;
            case 2:
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationFormScreen()),
            );
              break;
            case 3:
              // Handle New Request tap
              break;
          }
        },
      ),
    );
  }
}
