import 'package:cloud_firestore/cloud_firestore.dart';

class DonationService {
  // final CollectionReference notes =
  //     FirebaseFirestore.instance.collection('notes');
  // Future<void> addNote(String note) {
  //   return notes.add({
  //     'note': note,
  //     'timestamp': Timestamp.now(),
  //   });

  final CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  // generate  code to test db
  Future<void> generateCode() async {
    await donations.add({
      'title': 'Test Donation',
      'description': 'This is a test donation',
      'category': 'donation', // donation or request
      'contact': 'gamithf',
      'location': 'Kathmandu',
    });
  }

  // Create a donation
  Future<void> addDonation(String? title, String? description, String? category,
      String? contact, String? location) {
    return donations.add({
      'title': title ?? '',
      'description': description ?? '',
      'category': category ?? '', // donation or request
      'contact': contact ?? '',
      'location': location ?? '',
      'timestamp': Timestamp.now(),
    });
  }

  // Stream of donations
  Stream<QuerySnapshot> getDonations() {
    final donationsStream =
        donations.orderBy('timestamp', descending: true).snapshots();
    return donationsStream;
  }

  // create a get method to get a single donation
  Future<DocumentSnapshot> getDonation(String id) {
    return donations.doc(id).get();
  }
}
