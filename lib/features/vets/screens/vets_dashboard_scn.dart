import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:pawpal/features/vets/screens/edit_vet_profile_screen.dart';
import 'package:pawpal/features/vets/screens/feedback_screen.dart';
import 'package:pawpal/features/vets/screens/manage_appointment.dart';
import 'package:pawpal/features/vets/screens/msg_list_screeen.dart';
import 'package:pawpal/features/vets/screens/pet_recodes_screen.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_bloc/vet_auth_state.dart';

// ignore_for_file: prefer_const_constructors
class VetsDashboardScn extends StatelessWidget {
  const VetsDashboardScn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<VetAuthBloc, VetAuthState>(
      builder: (context, state) {
        if (state is VetAuthSuccess || state is VetRegisterSuccess) {
          VetModel vet = (state as dynamic).vet;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Vet Dashboard'),
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigate to Settings
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  _buildProfileSection(context, vet, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),

                  // Quick Stats Section
                  _buildStatsSection(screenHeight),
                  SizedBox(height: screenHeight * 0.03),

                  // Feedback Tile
                  _buildInteractiveTile(
                    context,
                    icon: Icons.feedback,
                    title: 'Client Feedbacks',
                    subtitle: 'View feedback history',
                    color: Colors.purpleAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VetReviewsScreen(vetEmail: vet.email),
                        ),
                      );
                    },
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Messages Tile
                  _buildInteractiveTile(
                    context,
                    icon: Icons.message,
                    title: 'Messages',
                    subtitle: 'View client messages',
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesListScreen(),
                        ),
                      );
                    },
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Appointments Tile
                  _buildInteractiveTile(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Appointments',
                    subtitle: 'Manage your appointments',
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VetManageAppointmentsScreen(),
                        ),
                      );
                    },
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Pet Health Records Tile
                  _buildInteractiveTile(
                    context,
                    icon: Icons.pets,
                    title: 'Pet Health Records',
                    subtitle: 'Manage and view pet health records',
                    color: Colors.greenAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetHealthRecordsScreen(),
                        ),
                      );
                    },
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
            ),
          );
        } else {
          // Return a loading screen or error handling here if needed
          return Scaffold(
            appBar: AppBar(
              title: const Text('Vet Dashboard'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  // Profile Section
  Widget _buildProfileSection(BuildContext context, VetModel vet,
      double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditVetProfileScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.1,
              backgroundImage: Image.network(vet.profilePicUrl).image,
            ),
            SizedBox(width: screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${vet.fullName}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Veterinarian',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Stats section with charts or overview of important metrics
  Widget _buildStatsSection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Performance',
          style: TextStyle(
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: [
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: 8,
                      color: Colors.blueAccent,
                      width: 20,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: 10,
                      color: Colors.orangeAccent,
                      width: 20.0,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      toY: 14,
                      color: Colors.greenAccent,
                      width: 20.0,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                      toY: 6,
                      color: Colors.purpleAccent,
                      width: 20.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Interactive Tile Widget
  Widget _buildInteractiveTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
