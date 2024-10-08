import 'package:flutter/material.dart';
import 'package:pawpal/features/common/home_appbar.dart';

class PostingsScreen extends StatelessWidget {
  const PostingsScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Text('This is the Postings Screen'),
      ),
    );
  }
}
