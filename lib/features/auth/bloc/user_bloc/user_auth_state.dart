import 'package:pawpal/models/user_model.dart';

abstract class UserAuthState {}

class UserAuthInitial extends UserAuthState {}

class UserAuthLoading extends UserAuthState {}

// Login states
class UserAuthSuccess extends UserAuthState {
  final UserModel user;
  UserAuthSuccess(this.user);
}

class UserAuthFailure extends UserAuthState {
  final String error;
  UserAuthFailure(this.error);
}

// Register states
class UserRegisterInitial extends UserAuthState {}

class UserRegisterLoading extends UserAuthState {}

class UserRegisterSuccess extends UserAuthState {
  final UserModel user;
  UserRegisterSuccess(this.user);
}

class UserRegisterFailure extends UserAuthState {
  final String error;
  UserRegisterFailure(this.error);
}
