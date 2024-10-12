import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/features/common/widgets/home_appbar.dart';
import 'package:pawpal/features/common/widgets/post_drawer.dart';
import 'package:pawpal/features/common/widgets/return_nothing.dart';
import 'package:pawpal/features/discussions/screens/discussion_home_screen.dart';
import 'package:pawpal/features/donations/screens/donation_home_screen.dart';
import 'package:pawpal/features/postings/screens/postings_screen.dart';
import 'package:pawpal/features/vets/screens/vets_list_screen.dart';
import 'package:pawpal/core/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<HomeScreen> {
  int currentPageIndex = 0;
  bool showDialogAboveNavBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const HomeAppBar(), //custom top app bar - nav containing branding and user profile

      /* Bottom navigation bar including bottom app drawer display*/
      body: Stack(
        children: [
          [
            /* Set each page content here in order :
            - Home page,
            - Community space,
            -----PLACEHOLDER WIDGET----
            - Post drawer,
            - Donations screen
             */

            //Home page
            const PostingsScreen(),

            //community space
            const DiscussionsHomeScreen(),

            DoNothingWidget(), // This is a placeholder widget that does nothing to prevent screen change

            //donations screen
            DonationHomeScreen(),

            //vets screen
            const VetsListScreen(),
          ][currentPageIndex],
          if (showDialogAboveNavBar)
            Positioned(
              bottom:
                  85, // Adjust this value to position the dialog above the navbar
              left: 10,
              right: 10,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    // OVERLAY CONTENT GOES HERE TO CHILD
                    child: const PostDrawer(),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.only(
                  bottom: 0, top: 16.0), // Reduce bottom padding

              child: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                    showDialogAboveNavBar = false;
                  });
                },
                indicatorColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                height: 40, // Adjust height if necessary
                // Navigation destinations : Icons and labels
                destinations: <Widget>[
                  NavigationDestination(
                    icon: SvgPicture.asset(AppVectors.homeNeutralIcon),
                    selectedIcon: SvgPicture.asset(AppVectors.homeSelectedIcon),
                    label: '',
                  ),
                  NavigationDestination(
                    icon:
                        SvgPicture.asset(AppVectors.communitySpaceNeutralIcon),
                    selectedIcon:
                        SvgPicture.asset(AppVectors.communitySpaceSelectedIcon),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showDialogAboveNavBar = !showDialogAboveNavBar;
                        });
                      },
                      child: Material(
                        elevation: 0.5, // Add shadow here
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              ThemeData.light().colorScheme.surface,
                          child: const Icon(Icons.add,
                              color: AppColors.iconBlack, size: 34),
                        ),
                      ),
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(AppVectors.donationsNeutralIcon),
                    selectedIcon:
                        SvgPicture.asset(AppVectors.donationsSelectedIcon),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(AppVectors.vetNeutralIcon),
                    selectedIcon: SvgPicture.asset(AppVectors.vetSelectedIcon),
                    label: '',
                  ),
                ],
              ));
        },
      ),
    );
  }
}
