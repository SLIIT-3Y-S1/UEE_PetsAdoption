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
            children: [],
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
            children: [],
          ),
        ),
        // Rest of the donation records go here (list)
        Expanded(child: OpenDonationRecord()),
      ],
    );
  }
}
