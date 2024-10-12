import 'package:cloud_firestore/cloud_firestore.dart';

class DonationService {
  final CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  final CollectionReference openDonations =
      FirebaseFirestore.instance.collection('openDonations');

  // Create a donation with image URLs
  Future<void> addDonation(
      String? title,
      String? description,
      String? category,
      String? contact,
      String? location,
      bool? isUrgent,
      String? user,
      List<String> imageUrls) {
    return donations.add({
      'title': title ?? '',
      'description': description ?? '',
      'category': category ?? '', // donation or request
      'contact': contact ?? '',
      'location': location ?? '',
      'isUrgent': isUrgent ?? false,
      'images': imageUrls, // Add image URLs
      'user': user, // Add image URLs
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addOpenDonation(
      String? title,
      String? description,
      String? category,
      String? contact,
      String? location,
      bool? isAvailable,
      String? user,
      List<String> imageUrls) {
    return openDonations.add({
      'title': title ?? '',
      'description': description ?? '',
      'category': category ?? '', // donation or request
      'contact': contact ?? '',
      'location': location ?? '',
      'isAvailable': isAvailable ?? false,
      'images': imageUrls,
      'user': user, // Add image URLs
      'timestamp': Timestamp.now(),
    });
  }

  // Stream of donations
  Stream<QuerySnapshot> getDonations() {
    final donationsStream =
        donations.orderBy('timestamp', descending: true).snapshots();
    return donationsStream;
  }

  Stream<QuerySnapshot> getOpenDonations() {
    final donationsStream =
        openDonations.orderBy('timestamp', descending: true).snapshots();
    return donationsStream;
  }

  // Get a single donation by ID
  Future<DocumentSnapshot> getDonation(String id) {
    return donations.doc(id).get();
  }

  Future<DocumentSnapshot> getOpenDonation(String id) {
    return openDonations.doc(id).get();
  }
}
