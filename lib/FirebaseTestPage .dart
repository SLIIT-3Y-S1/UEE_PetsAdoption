// import "package:flutter/material.dart";
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseTestPage extends StatelessWidget {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   FirebaseTestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Firebase Firestore Test")),
//       body: FutureBuilder(
//         future: firestore.collection('test').get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           // Display Firestore data
//           final data = snapshot.data?.docs.first.data();
//           return Center(child: Text("Firestore Data: ${data ?? 'No data'}"));
//         },
//       ),
//     );
//   }
// }