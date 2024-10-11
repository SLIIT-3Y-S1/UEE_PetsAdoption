import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Join Us!',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.accentRed,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Create your vet account.',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}