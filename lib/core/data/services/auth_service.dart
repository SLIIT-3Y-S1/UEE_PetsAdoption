import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawpal/core/data/model/auth/signupReq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthService {
  Future<void> signUp(SignUpReq signUpReq);
  Future<void> login();
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> login () async{}
 
 
  @override
  Future<void> signUp(SignUpReq signUpReq) async {
   try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: signUpReq.email,
        password: signUpReq.password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      // Save additional user data in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': signUpReq.firstName,
          'lastName': signUpReq.lastName,
          'userName': signUpReq.userName,
          'email': signUpReq.email,
        });
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
}

}
