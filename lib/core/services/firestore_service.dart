import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawpal/features/vets/models/reviewModel.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';

class FirestoreService {
  Future<VetModel?> addVetToFirestore(VetModel vet) async {
    try {
      final createDoc =
          FirebaseFirestore.instance.collection('vets').doc(vet.email).set({});
      await FirebaseFirestore.instance
          .collection('vets')
          .doc(vet.email)
          .collection('personal_info')
          .doc('details')
          .set(vet.toMap());

      return vet;
    } catch (e) {
      print('Error saving vet data: $e');
      return null;
    }
  }

  Future<VetModel?> getVetData(String email) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('vets')
          .doc(email)
          .collection('personal_info')
          .doc('details')
          .get(); // Fetch from 'personal_info/details' document

      if (doc.exists) {
        return VetModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error getting vet data: $e');
    }
    return null;
  }

  Future<void> updateVetData({
    required String email,
    String? fullName,
    String? phone,
    String? clinicLocation,
    String? bio,
    required List<dynamic> services,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('vets')
          .doc(email)
          .collection('personal_info')
          .doc('details')
          .update({
        if (fullName != null) 'fullName': fullName,
        if (phone != null) 'phone': phone,
        if (clinicLocation != null) 'clinicLocation': clinicLocation,
        if (bio != null) 'bio': bio,
        'services': services,
      });
    } catch (e) {
      print('Error updating vet data: $e');
    }
  }

  Future<void> updateVetProfilePic(String email, String profilePicUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('vets')
          .doc(email)
          .collection('personal_info')
          .doc('details')
          .update({
        'profilePicUrl': profilePicUrl,
      });
    } catch (e) {
      print('Error updating vet profile picture: $e');
    }
  }

// fetch all vetsList---------------------------------
  Future<List<VetModel>> getVetList() async {
    try {
      final QuerySnapshot vetsSnapshot =
          await FirebaseFirestore.instance.collection('vets').snapshots().first;

      List<VetModel> vetsList = [];

      for (var vetDoc in vetsSnapshot.docs) {
        DocumentSnapshot personalInfo = await FirebaseFirestore.instance
            .collection('vets')
            .doc(vetDoc.id)
            .collection('personal_info')
            .doc('details')
            .get();

        if (personalInfo.exists) {
          vetsList.add(
              VetModel.fromMap(personalInfo.data() as Map<String, dynamic>));
        } else {
          print(
              'No personal info found for vet: ${vetDoc.id}'); // Debugging step
        }
      }

      return vetsList;
    } catch (e) {
      print("Error fetching vet list: $e");
      return [];
    }
  }

  //--------------- reviews--------------------

  Future<void> addReviewToFirestore(String vetEmail, ReviewModel review) async {
    try {
      await FirebaseFirestore.instance
          .collection('vets')
          .doc(vetEmail)
          .collection('reviews')
          .add(review.toMap());
      print('Review added successfully');
    } catch (e) {
      print('Error adding review: $e');
    }
  }

  Future<List<ReviewModel>> fetchReviewsForVet(String vetEmail) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('vets')
          .doc(vetEmail)
          .collection('reviews')
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }

  Future<void> updateRatingForVet(String vetEmail, double newRating) async {
    try {
      await FirebaseFirestore.instance
          .collection('vets')
          .doc(vetEmail)
          .collection('personal_info')
          .doc('details')
          .update({
        'rating': newRating,
      });
    } catch (e) {
      print('Error updating vet rating: $e');
    }
  }

  Future<List<VetModel>> fetchTopRatedVets() async {
    try {
      // Get all vet documents (vetEmails)
      final QuerySnapshot vetsSnapshot =
          await FirebaseFirestore.instance.collection('vets').get();

      List<VetModel> topRatedVets = [];

      print('Vets snapshot: ${vetsSnapshot.docs.length}');
      for (var vetDoc in vetsSnapshot.docs) {
        // Fetch the 'details' document from the 'personal_info' subcollection
        DocumentSnapshot personalInfo = await FirebaseFirestore.instance
            .collection('vets')
            .doc(vetDoc.id)
            .collection('personal_info')
            .doc('details')
            .get();

        if (personalInfo.exists) {
          final personalInfoData = personalInfo.data() as Map<String, dynamic>;
          final double rating = personalInfoData['rating'] ?? 0.0;
          print('Rating: $rating');

          // Filter vets with a rating greater than 3
          if (rating > 3) {
            topRatedVets.add(VetModel.fromMap(personalInfoData));
            print('Added vet: ${vetDoc.id}');
          }
        } else {
          print('No personal info found for vet: ${vetDoc.id}');
        }
      }

      // Sort the filtered vets by their rating in descending order
      topRatedVets.sort((a, b) => b.rating.compareTo(a.rating));
      print('Top rated vets: ${topRatedVets.length}');

      return topRatedVets;
    } catch (e) {
      print("Error fetching top-rated vets: $e");
      return [];
    }
  }
}
