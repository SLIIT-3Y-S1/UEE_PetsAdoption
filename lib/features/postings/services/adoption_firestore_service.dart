import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawpal/features/postings/models/adoption_post_model.dart';

class AdoptionFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference adoptionPosts =
      FirebaseFirestore.instance.collection('adoptionPosts');

// Create
  Future<void> createAdoptionPost(AdoptionPostModel post) async {
    await adoptionPosts.add(post.toMap());
  }


  // Stream of donations
  Stream<QuerySnapshot> getAdoptionPosts() {
    final adoptionPostStream =
        adoptionPosts.orderBy('timestamp', descending: true).snapshots();
    return adoptionPostStream;
  }

// Update
  Future<void> updateAdoptionPost(String id, AdoptionPostModel post) async {
    await adoptionPosts.doc(id).update(post.toMap());
  }

// Delete
  Future<void> deleteAdoptionPost(String id) async {
    await adoptionPosts.doc(id).delete();
  }


//     Future<AdoptionPostModel?> getAdoptionPostByID(String id) async {
//   final doc = await adoptionPosts.doc(id).get();
//   if (doc.exists) {
//     return AdoptionPostModel.fromMap(doc.data() as Map<String, dynamic>);
//   }
//   return null;
// }

  // create a get method to get a single donation
  Future<DocumentSnapshot> getpost(String id) {
    return adoptionPosts.doc(id).get();
  }

}
