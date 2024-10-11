import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/widgets/donation_record.dart';
import 'package:pawpal/features/donations/widgets/open_donation_record.dart';

class DonationRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by keywords',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.filter_list),
                label: Text('Filter'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.priority_high),
                            title: Text('Urgent'),
                            onTap: () {
                              // Implement urgent filter functionality
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text('Recent'),
                            onTap: () {
                              // Implement recent filter functionality
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        // Rest of the donation records go here (list)
        Expanded(child: DonationRecord()),
      ],
    );
  }
}

class OpenDonationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by keywords',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement filter functionality
                },
                icon: Icon(Icons.filter_list),
                label: Text('Filter'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Rest of the donation records go here (list)
        Expanded(child: OpenDonationRecord()),
      ],
    );
  }
}
