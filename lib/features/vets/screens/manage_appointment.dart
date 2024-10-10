import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VetManageAppointmentsScreen extends StatefulWidget {
  const VetManageAppointmentsScreen({super.key});

  @override
  _VetManageAppointmentsScreenState createState() =>
      _VetManageAppointmentsScreenState();
}

class _VetManageAppointmentsScreenState
    extends State<VetManageAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  // Sample list of appointments with 'state' added for each
  List<Map<String, dynamic>> appointments = [
    {
      'client': 'Alice Johnson',
      'pet': 'Charlie (Dog)',
      'date': DateTime.now().add(Duration(hours: 3)),
      'time': '2:00 PM',
      'notes': 'Routine check-up and vaccination.',
      'state': 'Pending', // State: Pending or Completed
    },
    {
      'client': 'Bob Smith',
      'pet': 'Whiskers (Cat)',
      'date': DateTime.now().add(Duration(days: 1)),
      'time': '11:00 AM',
      'notes': 'Concern about a leg injury.',
      'state': 'Pending',
    },
    {
      'client': 'Charlie Brown',
      'pet': 'Max (Dog)',
      'date': DateTime.now().add(Duration(hours: 24)),
      'time': '9:00 AM',
      'notes': 'Dental cleaning appointment.',
      'state': 'Completed',
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Manage Appointments')),
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentsList('Pending'), // Pending appointments tab
          _buildAppointmentsList('Completed'), // Completed appointments tab
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(String state) {
    // Filter appointments by their state (Pending or Completed)
    final filteredAppointments = appointments.where((appointment) {
      return appointment['state'] == state;
    }).toList();

    return filteredAppointments.isNotEmpty
        ? ListView.builder(
            itemCount: filteredAppointments.length,
            itemBuilder: (context, index) {
              final appointment = filteredAppointments[index];
              return _buildAppointmentCard(appointment);
            },
          )
        : Center(
            child: Text(
              'No $state appointments found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Name and Pet Details
            Text(
              '${appointment['client']} - ${appointment['pet']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Appointment Date and Time
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  DateFormat.yMMMd().format(appointment['date']),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Spacer(),
                Icon(Icons.access_time, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  appointment['time'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Notes
            Text(
              'Notes: ${appointment['notes']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 10),

            // Action Buttons (only show 'Complete' for Pending appointments)
            appointment['state'] == 'Pending'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            // Mark the appointment as completed
                            appointment['state'] = 'Completed';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Appointment marked as completed!')),
                          );
                        },
                        icon: Icon(Icons.check_circle, color: Colors.white),
                        label: Text(
                          'Complete',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Logic to reschedule the appointment
                          _rescheduleAppointment(appointment);
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
                        label: Text('Reschedule',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  )
                : Container(), // No actions for completed appointments
          ],
        ),
      ),
    );
  }

  // Function to reschedule an appointment
  Future<void> _rescheduleAppointment(Map<String, dynamic> appointment) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: appointment['date'],
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      setState(() {
        appointment['date'] = newDate;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment rescheduled!')),
        );
      });
    }
  }
}
