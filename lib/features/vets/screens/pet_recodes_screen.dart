import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PetHealthRecordsScreen extends StatefulWidget {
  @override
  _PetHealthRecordsScreenState createState() => _PetHealthRecordsScreenState();
}

class _PetHealthRecordsScreenState extends State<PetHealthRecordsScreen> {
  List<Map<String, dynamic>> healthRecords = [
    {
      'petName': 'Charlie (Dog)',
      'lastCheckup': DateTime.now().subtract(Duration(days: 30)),
      'status': 'Healthy',
      'nextDue': DateTime.now().add(Duration(days: 60)),
    },
    {
      'petName': 'Whiskers (Cat)',
      'lastCheckup': DateTime.now().subtract(Duration(days: 15)),
      'status': 'Minor Cold',
      'nextDue': DateTime.now().add(Duration(days: 45)),
    },
    {
      'petName': 'Max (Dog)',
      'lastCheckup': DateTime.now().subtract(Duration(days: 60)),
      'status': 'Dental Cleaning Needed',
      'nextDue': DateTime.now().add(Duration(days: 30)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Health Records'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              Expanded(
                child: _buildHealthRecordList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pet Health Records',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Manage and view pet health records',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthRecordList() {
    return ListView.builder(
      itemCount: healthRecords.length,
      itemBuilder: (context, index) {
        final record = healthRecords[index];
        return _buildHealthRecordCard(record);
      },
    );
  }

  Widget _buildHealthRecordCard(Map<String, dynamic> record) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusIcon(record['status']),
                SizedBox(width: 16),
                Expanded(child: _buildPetInfo(record)),
              ],
            ),
            SizedBox(height: 12),
            _buildNextDueDate(record['nextDue']),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData iconData;
    Color iconColor;

    switch (status) {
      case 'Healthy':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'Minor Cold':
        iconData = Icons.warning;
        iconColor = Colors.orange;
        break;
      case 'Dental Cleaning Needed':
        iconData = Icons.local_hospital;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.help_outline;
        iconColor = Colors.grey;
    }

    return Icon(
      iconData,
      size: 40,
      color: iconColor,
    );
  }

  Widget _buildPetInfo(Map<String, dynamic> record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          record['petName'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Last Checkup: ${DateFormat.yMMMd().format(record['lastCheckup'])}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 4),
        Text(
          'Status: ${record['status']}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildNextDueDate(DateTime nextDue) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Next Checkup',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 4),
          Text(
            DateFormat.yMMMd().format(nextDue),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
