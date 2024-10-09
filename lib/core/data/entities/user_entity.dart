import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String email;
  final String accountType;
  final String? profilePicture;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.email,
    this.accountType = 'default',
    this.profilePicture, 
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'password': password,
      'email': email,
      'accountType': accountType,
      'profilePicture': profilePicture,
    };
  }

  static UserEntity fromDocument(Map<String, Object?> doc) {
    return UserEntity(
      id: doc['id'] as String,
      firstName: doc['firstName'] as String,
      lastName: doc['lastName'] as String,
      userName: doc['userName'] as String,
      password: doc['password'] as String,
      email: doc['email'] as String,
      accountType: doc['accountType'] as String,
      profilePicture: doc['profilePicture'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [id, firstName, lastName, userName, password, email,accountType, profilePicture];

  @override
  String toString() {
    return '''UserEntity { 
      id:$id, 
      firstName: $firstName, 
      lastName: $lastName, 
      userName: $userName, 
      password: $password, 
      email: $email, 
      accountType: $accountType,
      profilePicture: $profilePicture 
    }''';
  }

}
