import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VetAppointmentScreen extends StatefulWidget {
  @override
  _VetAppointmentScreenState createState() => _VetAppointmentScreenState();
}

class _VetAppointmentScreenState extends State<VetAppointmentScreen> {
  // List of available times for booking
  final List<String> _availableTimes = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
  ];

  String? _selectedTime;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vet Image and Name Section
            _buildVetInfo(),
            SizedBox(height: 20),

            // Date Picker Section
            _buildDatePicker(context),
            SizedBox(height: 20),

            // Time Picker Section
            _buildTimePicker(),
            SizedBox(height: 20),

            // Notes Section
            _buildNotesSection(),
            SizedBox(height: 20),

            // Submit Button
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVetInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/vet_avatar.jpg'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Emily Brown',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Veterinary Specialist',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.blueAccent),
            SizedBox(width: 16),
            Text(
              'Appointment Date: ${DateFormat.yMMMd().format(_selectedDate)}',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.blueAccent),
          SizedBox(width: 16),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select Time'),
              value: _selectedTime,
              items: _availableTimes.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (newTime) {
                setState(() {
                  _selectedTime = newTime;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return TextField(
      controller: _notesController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Additional Notes (optional)',
        border: OutlineInputBorder(),
        hintText: 'Describe your pet\'s needs or any concerns...',
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Confirm Appointment Logic Here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment Booked Successfully!')),
          );
        },
        icon: Icon(Icons.check),
        label: Text(
          'Confirm Appointment',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          backgroundColor: Colors.blueAccent,
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
