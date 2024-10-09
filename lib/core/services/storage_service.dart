import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class StorageService {
  Future<String?> uploadVetProfileImage(File imageFile, String email) async {
    try {
      // Define the storage path
      String storagePath = 'vets/$email/profile_pic';

      // Upload the file to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child(storagePath);
      UploadTask uploadTask = ref.putFile(imageFile);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String?> uploadVetProfileImageWeb(
      XFile imageFile, String email) async {
    try {
      // Convert image to bytes for web upload
      final Uint8List imageBytes = await imageFile.readAsBytes();

      // Create a reference in Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('vets')
          .child(email)
          .child('profile_pic');

      // Upload image bytes to Firebase Storage
      final uploadTask = storageRef.putData(imageBytes);

      // Wait for the upload to complete and get the download URL
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl; // Return the download URL
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
