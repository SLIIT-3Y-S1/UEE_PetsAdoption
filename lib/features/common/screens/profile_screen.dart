import 'package:flutter/material.dart';
import 'package:pawpal/features/common/widgets/profile_appbar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProfileAppbar(),
      body: Center(
        child: Text('This is the profile screen'),
      ),
    );
  }
}
