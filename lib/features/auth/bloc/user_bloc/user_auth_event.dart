import 'package:pawpal/models/user_model.dart';

abstract class UserAuthEvent {}

class UserAuthLoginRequested extends UserAuthEvent {
  final String email;
  final String password;

  UserAuthLoginRequested({required this.email, required this.password});
}

class UserAuthRegisterRequested extends UserAuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String username;

  UserAuthRegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
  });
}

class UserAuthLogoutRequested extends UserAuthEvent {}
