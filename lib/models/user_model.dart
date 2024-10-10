import 'package:uuid/uuid.dart';

class UserModel {
  final String id = Uuid().v4();
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String photoUrl;
  final String bio;
  final String location;
  final String phoneNumber;

  UserModel(
      {String? id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      this.photoUrl = '',
      this.bio = '',
      this.location = '',
      this.phoneNumber = ''});

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? photoUrl,
    String? bio,
    String? location,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'location': location,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      bio: map['bio'],
      location: map['location'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
