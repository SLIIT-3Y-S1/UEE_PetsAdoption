// vet_auth_state.dart
import 'package:pawpal/features/vets/models/vetModel.dart';

abstract class VetAuthState {}

class VetAuthInitial extends VetAuthState {}

class VetAuthLoading extends VetAuthState {}

class VetAuthSuccess extends VetAuthState {
  final VetModel vet;

  VetAuthSuccess(this.vet);
}

class VetAuthFailure extends VetAuthState {
  final String error;

  VetAuthFailure(this.error);
}
