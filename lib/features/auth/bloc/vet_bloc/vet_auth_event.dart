// vet_auth_event.dart
abstract class VetAuthEvent {}

class VetAuthLoginRequested extends VetAuthEvent {
  final String email;
  final String password;

  VetAuthLoginRequested({required this.email, required this.password});
}
// register vet event
class VetAuthRegisterRequested extends VetAuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String clinicLocation;
  final String nic;
  final String vetLicenseNo;
  final String clinicName;
  final DateTime issueDate;

  VetAuthRegisterRequested({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.clinicLocation,
    required this.nic,
    required this.vetLicenseNo,
    required this.clinicName,
    required this.issueDate,

  });
}

class VetAuthLogoutRequested extends VetAuthEvent {}


class UpdateVetDetails extends VetAuthEvent {
  final List<String> updatedPersonalDetails;
  UpdateVetDetails(this.updatedPersonalDetails);
}