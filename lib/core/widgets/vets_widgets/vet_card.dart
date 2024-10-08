import 'package:flutter/material.dart';
import 'package:pawpal/features/vets/screens/vet_profile_screen.dart';

class VetCard extends StatelessWidget {
  const VetCard({super.key});
  void _showCallDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Call Vet'),
          content: const Text('Do you want to call this vet?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const VetProfileScreen();
        }));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/vets1.jpg'),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. John Doe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black12,
                                ),
                                Text('Kampala'),
                              ],
                            ),
                            SizedBox(width: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text('4.5'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                  IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () => _showCallDialogBox(context)),
                ]),
          ),
        ),
      ),
    );
  }
}
