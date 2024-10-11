class VetModel {
  final String fullName;
  final String email;
  final String phone;
  final String clinicLocation;
  final String nic;
  final String vetLicenseNo;
  DateTime? issueDate;
  final String clinicName;
  final String bio;
  final String profilePicUrl;
  List<dynamic> services; // Changed to dynamic to allow modification
  final double rating;

  VetModel({
    required this.fullName,
    required this.email,
    required this.phone,
    this.clinicName = '',
    required this.clinicLocation,
    this.nic = '',
    this.vetLicenseNo = '',
    DateTime? issueDate,
    this.bio = 'Bio here, this is my bio details',
    this.profilePicUrl = '',
    this.services = const ['Vaccination', 'Surgery', 'Dental Care'],
    this.rating = 0.0, // default rating is 0.0
  });
  VetModel copyWith({
    String? fullName,
    String? phone,
    String? clinicLocation,
    String? bio,
    List<dynamic>? services,
    String? email,
    String? profilePicUrl,
  }) {
    return VetModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      bio: bio ?? this.bio,
      services: services ?? this.services,
      email: email ?? this.email,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'clinicName': clinicName,
      'clinicLocation': clinicLocation,
      'nic': nic,
      'vetLicenseNo': vetLicenseNo,
      'issueDate': issueDate?.toIso8601String(),
      'bio': bio,
      'profilePicUrl': profilePicUrl,
      'services': services,
      'rating': rating,
    };
  }

  // Create VetModel object from Firebase document
  factory VetModel.fromMap(Map<String, dynamic> map) {
    return VetModel(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      clinicName: map['clinicName'] ?? '',
      clinicLocation: map['clinicLocation'] ?? '',
      nic: map['nic'] ?? '',
      vetLicenseNo: map['vetLicenseNo'] ?? '',
      issueDate:
          DateTime.parse(map['issueDate'] ?? DateTime.now().toIso8601String()),
      bio: map['bio'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      services: List<dynamic>.from(map['services'] ?? []),
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  // Add a new service to the list
  void addService(String service) {
    services.add(service);
  }

  // Remove a service from the list
  void removeService(String service) {
    services.remove(service);
  }

  // Update an existing service in the list
  void updateService(int index, String newService) {
    if (index >= 0 && index < services.length) {
      services[index] = newService;
    }
  }
}
