// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/services/firestore_service.dart';
// import 'package:pawpal/core/services/storage_service.dart';
// import 'package:pawpal/features/vets/models/vetModel.dart';
// import 'dart:io';

// // Events
// abstract class VetEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class LoadVetData extends VetEvent {
//   final VetModel vet;
//   LoadVetData({required this.vet});
// }

// class UpdateVetData extends VetEvent {
//   final String email;
//   final String? fullName;
//   final String? phone;
//   final String? clinicLocation;
//   final String? bio;
//   final List<dynamic> services;

//   UpdateVetData({
//     required this.email,
//     this.fullName,
//     this.phone,
//     this.clinicLocation,
//     this.bio,
//     required this.services,
//   });
// }

// class UpdateVetProfileImage extends VetEvent {
//   final File image;
//   final String email;
  
//   UpdateVetProfileImage({required this.image, required this.email});
// }

