import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawpal/core/data/model/user_model.dart';

abstract class UserRepo {
  
  //Authentication
  Future<UserModel> signUp(UserModel user,String password);
  Future<void> signIn(String email,String password);
  Future<void> signOut();

  //set user data
  Future<void> setUserData(UserModel user);
  
  //get user data
  Future<UserModel> getUserData(String id);

  //get user stream
  Stream<User?> get user;
}