// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/data/entities/user_entity.dart';

// class UserModel extends Equatable {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String userName;
//   final String password;
//   final String email;
//   final String accountType;
//   final String? profilePicture;

//   const UserModel(
//       {required this.id,
//       required this.firstName,
//       required this.lastName,
//       required this.userName,
//       required this.password,
//       required this.email,
//       this.accountType = 'default',
//       this.profilePicture});

//   // Empty user : Unauthenticated User
//   static const empty = UserModel(
//     id: '',
//     firstName: '',
//     lastName: '',
//     userName: '',
//     password: '',
//     accountType: '',
//     email: '',
//   );

//   // Method : Modify user details
//   UserModel copyWith({
//     String? id,
//     String? firstName,
//     String? lastName,
//     String? userName,
//     String? password,
//     String? email,
//     String? accountType,
//     String? profilePicture,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       userName: userName ?? this.userName,
//       password: password ?? this.password,
//       email: email ?? this.email,
//       accountType: accountType ?? this.accountType,
//       profilePicture: profilePicture ?? this.profilePicture,
//     );
//   }

//   // User Empty Check
//   bool get isEmpty => this == UserModel.empty;

//   // User Not Empty Check
//   bool get isNotEmpty => this != UserModel.empty;

//   // Convert to Entity
//   UserEntity toEntity() {
//     return UserEntity(
//       id: id,
//       firstName: firstName,
//       lastName: lastName,
//       userName: userName,
//       password: password,
//       email: email,
//       accountType: accountType,
//       profilePicture: profilePicture,
//     );
//   }

//   //Get from entity
//   static fromEntity(UserEntity fromDocument) {
//     return UserModel(
//       id: fromDocument.id,
//       firstName: fromDocument.firstName,
//       lastName: fromDocument.lastName,
//       userName: fromDocument.userName,
//       password: fromDocument.password,
//       email: fromDocument.email,
//       accountType: fromDocument.accountType,
//       profilePicture: fromDocument.profilePicture,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [id, firstName, lastName, userName, password, email,accountType, profilePicture];

// }
