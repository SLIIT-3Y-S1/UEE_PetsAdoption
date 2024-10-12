import 'package:cloud_firestore/cloud_firestore.dart';

class AdoptionFirestoreService {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference adoptionPosts = FirebaseFirestore.instance.collection('adoptionPosts');

  //create

  //read

  //update

  //delete

  Future<List<Map<String, dynamic>>> getPosts() async {
    final posts = await _firestore.collection('posts').get();
    return posts.docs.map((doc) => doc.data()).toList();
  }
}