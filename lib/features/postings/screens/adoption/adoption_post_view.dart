// import 'package:flutter/material.dart';
// import 'package:pawpal/features/postings/models/adoption_post_model.dart';
// import 'package:pawpal/features/postings/services/adoption_firestore_service.dart';
// import 'package:pawpal/theme/theme.dart';

// class AdoptionPostView extends StatefulWidget {
//   final String adoptionID;

//   const AdoptionPostView({Key? key, required this.adoptionID}) : super(key: key);

//   @override
//   _AdoptionPostViewState createState() => _AdoptionPostViewState();
// }

// class _AdoptionPostViewState extends State<AdoptionPostView> {
//   final AdoptionFirestoreService _firestoreService = AdoptionFirestoreService();
//   AdoptionPostModel? _adoptionPost;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAdoptionPost();
//   }

//   Future<void> _fetchAdoptionPost() async {
//     final post = await _firestoreService.getAdoptionPostByID(widget.adoptionID);
//     setState(() {
//       _adoptionPost = post;
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Adoption Post')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (_adoptionPost == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Adoption Post')),
//         body: Center(child: Text('Adoption post not found.')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text(_adoptionPost!.palname)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(_adoptionPost!.imageUrl),
//             SizedBox(height: 16),
//             Text('Breed: ${_adoptionPost!.breed}', style: AppTheme.lightTheme.textTheme.bodyMedium),
//             Text('Age: ${_adoptionPost!.age} years', style: AppTheme.lightTheme.textTheme.bodyMedium),
//             Text('Gender: ${_adoptionPost!.gender}', style: AppTheme.lightTheme.textTheme.bodyMedium),
//             Text('City: ${_adoptionPost!.city}', style: AppTheme.lightTheme.textTheme.bodyMedium),
//             Text('Availability: ${_adoptionPost!.availability}', style: AppTheme.lightTheme.textTheme.bodyMedium),
//           ],
//         ),
//       ),
//     );
//   }
// }