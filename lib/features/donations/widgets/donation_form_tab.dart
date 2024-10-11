import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/screens/donation_request_form.dart';

class DonationFormRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rest of the donation records go here (list)
        Expanded(child: DonationRequestForm()),
      ],
    );
  }
}

class OpenDonationsFormTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rest of the donation records go here (list)
        Expanded(child: DonationRequestForm()),
      ],
    );
  }
}
