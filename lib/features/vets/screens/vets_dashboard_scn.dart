import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:pawpal/features/vets/screens/edit_vet_profile_screen.dart';
import 'package:pawpal/features/vets/screens/feedback_screen.dart';
import 'package:pawpal/features/vets/screens/manage_appointment.dart';
import 'package:pawpal/features/vets/screens/msg_list_screeen.dart';
import 'package:pawpal/features/vets/screens/pet_recodes_screen.dart';
import 'package:pawpal/features/auth/bloc/vet_auth_bloc.dart';
import 'package:pawpal/features/auth/bloc/vet_auth_state.dart';

// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_unnecessary_containers
class VetsDashboardScn extends StatelessWidget {
  const VetsDashboardScn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VetAuthBloc, VetAuthState>(
      builder: (context, state) {
        if (state is VetAuthSuccess) {
          VetModel vet = state.vet;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Vet Dashboard'),
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Navigate to Notifications
                  },
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  _buildProfileSection(context, vet),

                  const SizedBox(height: 30),
                  // Quick Stats Section
                  _buildStatsSection(),
                  const SizedBox(height: 30),

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
                  ),
                  const SizedBox(height: 20),

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
                  ),
                  const SizedBox(height: 20),

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
                  ),
                  const SizedBox(height: 20),

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
  Widget _buildProfileSection(BuildContext context, VetModel vet) {
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
        padding: const EdgeInsets.all(20),
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
              radius: 40,
              backgroundImage: Image.network(vet.profilePicUrl).image,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${vet.fullName}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Veterinarian',
                  style: TextStyle(
                    fontSize: 16,
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
  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Performance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
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
                        toY: 10, color: Colors.orangeAccent, width: 20.0),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                        toY: 14, color: Colors.greenAccent, width: 20.0),
                  ],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                        toY: 6, color: Colors.purpleAccent, width: 20.0),
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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
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
