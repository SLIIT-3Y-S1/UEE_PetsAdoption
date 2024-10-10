import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpal/core/assets/app_vectors.dart';
import 'package:pawpal/features/common/home_appbar.dart';
import 'package:pawpal/features/discussions/screens/discussion_home_screen.dart';
import 'package:pawpal/features/donations/screens/donation_home_screen.dart';
import 'package:pawpal/features/postings/screens/postings_screen.dart';
import 'package:pawpal/features/vets/screens/vets_list_screen.dart';


/// Flutter code sample for [NavigationBar].

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<Homescreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),

      /*put main component screen here*/

      body: [
        /// Home page
        const PostingsScreen(),

        //community space
        const DiscussionsHomeScreen(),

        //donations screen
        const DonationHomeScreen(),

        //vets screen
         const VetsListScreen(),
      ][currentPageIndex],
      bottomSheet: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (BuildContext context) {
          return NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.transparent,
            selectedIndex: currentPageIndex,
            destinations: <Widget>[
              NavigationDestination(
                icon: SvgPicture.asset(AppVectors.homeNeutralIcon),
                selectedIcon: SvgPicture.asset(AppVectors.homeSelectedIcon),
                label: '',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppVectors.communitySpaceNeutralIcon),
                selectedIcon:SvgPicture.asset(AppVectors.communitySpaceSelectedIcon),
                label: '',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppVectors.donationsNeutralIcon),
                selectedIcon:SvgPicture.asset(AppVectors.donationsSelectedIcon),
                label: '',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppVectors.vetNeutralIcon),
                selectedIcon:SvgPicture.asset(AppVectors.vetSelectedIcon),
                label: '',
              ),
            ],
          );
        },
      ),
    );
  }
}
