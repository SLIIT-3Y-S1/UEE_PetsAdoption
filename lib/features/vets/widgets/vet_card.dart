import 'package:flutter/material.dart';
import 'package:pawpal/features/vets/models/reviewModel.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'package:pawpal/features/vets/screens/vet_profile_screen.dart';

class VetCard extends StatefulWidget {
  final VetModel vetModel;

  const VetCard({super.key, required this.vetModel});

  @override
  State<VetCard> createState() => _VetCardState();
}

class _VetCardState extends State<VetCard> {
  List<ReviewModel> reviewsList = [];

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
          return VetProfileScreen(vetModel: widget.vetModel);
        }));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          Image.network(widget.vetModel.profilePicUrl).image,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr.${widget.vetModel.fullName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.black12,
                                ),
                                Text(widget.vetModel.clinicLocation),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text('${widget.vetModel.rating}',
                                    style: const TextStyle(fontSize: 16)),
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
