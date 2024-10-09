import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/screens/donation_form_screen.dart';

class DonationRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // You can change this based on your data
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 400, // Adjust the height as needed
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Help Us Buy Dog Food',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('GoodDogsHome'),
                        SizedBox(height: 8),
                        Text(
                          'Urgent',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            'Description: We need funds to buy dog food for our shelter. Any help is appreciated.'),
                        SizedBox(height: 8),
                        Text('Date: 10 Jun 2024'),
                        Spacer(),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonationFormScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.yellow[200], // Light yellow color
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            child: Text('Contact'),
                          ),
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset('assets/images/dog_food.jpg',
                  width: 50), // Your image
              title: Text(
                'Help Us Buy Dog Food',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('GoodDogsHome'),
                  Text(
                    'Urgent',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: Text('10 Jun 2024'),
            ),
          ),
        );
      },
    );
  }
}
