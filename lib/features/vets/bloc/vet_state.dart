// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/services/firestore_service.dart';
// import 'package:pawpal/core/services/storage_service.dart';
// import 'package:pawpal/features/vets/models/vetModel.dart';
// import 'dart:io';


// // States
// abstract class VetState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class VetInitialState extends VetState {}

// class VetLoadingState extends VetState {}

// class VetLoadedState extends VetState {
//   final VetModel vet;
//   VetLoadedState(this.vet);

//   @override
//   List<Object> get props => [vet];
// }

// class VetErrorState extends VetState {
//   final String error;
//   VetErrorState(this.error);
// }
