// vet_auth_bloc.dart
import 'package:bloc/bloc.dart';
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
    // vet register request handler
    on<VetAuthRegisterRequested>((event, emit) async {
      emit(VetRegisterLoading());
      try {
        final user = await _authService.signUpWithEmailAndPassword(
            event.email, event.password);

        if (user != null) {
          final VetModel newVet = VetModel(
            email: event.email,
            fullName: event.fullName,
            phone: event.phone,
            clinicLocation: event.clinicLocation,
            nic: event.nic,
            vetLicenseNo: event.vetLicenseNo,
            clinicName: event.clinicName,
            issueDate: event.issueDate,
          );

          final VetModel? savedVet =
              await _firestoreService.addVetToFirestore(newVet);

          print('Saved vet: ${savedVet?.services}');
          print('Saved vet: ${savedVet?.nic}');
          print('Saved vet: ${savedVet?.bio}');

          if (savedVet != null) {
            emit(VetRegisterSuccess(savedVet));
          } else {
            emit(VetRegisterFailure('Failed to save vet data'));
          }
        }
      } catch (e) {
        emit(VetRegisterFailure('Registration failed: $e'));
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
