// vet_auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/core/services/firestore_service.dart';
import 'package:pawpal/features/vets/models/vetModel.dart';
import 'vet_auth_event.dart';
import 'vet_auth_state.dart';


class VetAuthBloc extends Bloc<VetAuthEvent, VetAuthState> {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  VetAuthBloc(this._authService, this._firestoreService)
      : super(VetAuthInitial()) {
    // Login request handler
    on<VetAuthLoginRequested>((event, emit) async {
      emit(VetAuthLoading());
      try {
        final user = await _authService.signInWithEmailAndPassword(
          event.email, event.password);
        
        if (user != null) {
          final VetModel? vet = await _firestoreService.getVetData(event.email);
          if (vet != null) {
            emit(VetAuthSuccess(vet));
          } else {
            emit(VetAuthFailure('Vet data not found'));
          }
        } else {
          emit(VetAuthFailure('Invalid email or password'));
        }
      } catch (e) {
        emit(VetAuthFailure('Login failed: $e'));
      }
    });

    // Update vet details event handler
    on<UpdateVetDetails>((event, emit) {
      if (state is VetAuthSuccess) {
        final currentState = state as VetAuthSuccess;
        
        // Create an updated VetModel
        final updatedVet = currentState.vet.copyWith(
          fullName: event.updatedPersonalDetails[0],
          phone: event.updatedPersonalDetails[1],
          clinicLocation: event.updatedPersonalDetails[2],
          bio: event.updatedPersonalDetails[3],
        );
        
        // Emit a new state with the updated VetModel
        emit(VetAuthSuccess(updatedVet));
      }
    });
  }
}
