// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/services/firestore_service.dart';
// import 'package:pawpal/core/services/storage_service.dart';
// import 'package:pawpal/features/vets/bloc/vet_event.dart';
// import 'package:pawpal/features/vets/bloc/vet_state.dart';
// import 'package:pawpal/features/vets/models/vetModel.dart';
// import 'dart:io';

// // BLoC
// class VetBloc extends Bloc<VetEvent, VetState> {
//   final FirestoreService firestoreService;
//   final StorageService storageService;

//   VetBloc({
//     required this.firestoreService,
//     required this.storageService,
//   }) : super(VetInitialState()) {
//     on<LoadVetData>(_onLoadVetData);
//     on<UpdateVetData>(_onUpdateVetData);
//     // on<UpdateVetProfileImage>(_onUpdateVetProfileImage);
//   }

//   Future<void> _onLoadVetData(
//       LoadVetData event, Emitter<VetState> emit) async {
//     emit(VetLoadingState());
//     try {
//       emit(VetLoadedState(event.vet));
//     } catch (e) {
//       emit(VetErrorState('Failed to load vet data.'));
//     }
//   }

//   Future<void> _onUpdateVetData(
//       UpdateVetData event, Emitter<VetState> emit) async {
//     emit(VetLoadingState());
//     try {
//       await firestoreService.updateVetData(
//         email: event.email,
//         fullName: event.fullName ?? '',
//         phone: event.phone,
//         clinicLocation: event.clinicLocation,
//         bio: event.bio,
//         services: event.services,
//       );
//       emit(VetLoadedState(VetModel(
//         email: event.email,
//         fullName: event.fullName ?? '',
//         phone: event.phone ?? '',
//         clinicLocation: event.clinicLocation ?? '',
//         bio: event.bio ?? '',
//         services: event.services,
//       )));
//     } catch (e) {
//       emit(VetErrorState('Failed to update vet data.'));
//     }
//   }

//   // Future<void> _onUpdateVetProfileImage(
//   //     UpdateVetProfileImage event, Emitter<VetState> emit) async {
//   //   emit(VetLoadingState());
//   //   try {
//   //     final String? imageUrl = await storageService.uploadVetProfileImage(
//   //         event.image, event.email);
//   //     if (imageUrl != null) {
//   //       await firestoreService.updateVetProfilePic(event.email, imageUrl);
//   //       emit(VetLoadedState(VetModel(
//   //         profilePicUrl: imageUrl,
//   //       )));
//   //     }
//   //   } catch (e) {
//   //     emit(VetErrorState('Failed to upload profile image.'));
//   //   }
//   // }
// }