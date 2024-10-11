import 'package:pawpal/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseServices {
  Future<UserModel?> addUserToFirebase(UserModel newUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.email)
          .set(newUser.toMap());
      return newUser;
    } catch (e) {
      print('Error saving user data: $e');
      return null;
    } catch (e) {
      print('Error saving user data: $e');
      return null;
    }
  }

  Future<UserModel?> getUserData(String email) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get(); // Fetch from 'users' document

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return null;
  }
}
