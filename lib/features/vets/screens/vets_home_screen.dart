import 'package:flutter/material.dart';

class VetsHomeScreen extends StatefulWidget {
  const VetsHomeScreen({super.key});

  @override
  State<VetsHomeScreen> createState() => _VetsHomeScreenState();
}

class _VetsHomeScreenState extends State<VetsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vets'),
      ),
      body: const Center(
        child: Text('Vets Home Screen'),
      ),
    );
  }
}