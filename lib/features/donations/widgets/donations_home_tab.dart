import 'package:flutter/material.dart';
import 'package:pawpal/features/donations/widgets/donation_record.dart';

class DonationRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(child: DonationRecord()),
      ],
    );
  }
}
