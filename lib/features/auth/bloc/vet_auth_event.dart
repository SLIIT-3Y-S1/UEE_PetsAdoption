// vet_auth_event.dart
abstract class VetAuthEvent {}

class VetAuthLoginRequested extends VetAuthEvent {
  final String email;
  final String password;

  VetAuthLoginRequested({required this.email, required this.password});
}

class VetAuthLogoutRequested extends VetAuthEvent {}


class UpdateVetDetails extends VetAuthEvent {
  final List<String> updatedPersonalDetails;
  UpdateVetDetails(this.updatedPersonalDetails);
}