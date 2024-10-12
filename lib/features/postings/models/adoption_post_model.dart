class AdoptionPostModel {
  final String email;
  final String palname;
  final String gender;
  final String animalType;
  final String breed;
  final String imageUrl;
  final double age;
  final double weight;
  final String description;
  final String isVaccinated;
  final String isTrained;
  final int contactNumber;
  final String city;
  final String address;
  final String availability;
  final DateTime timestamp;
  //final String postid;

  AdoptionPostModel({
    required this.email,
    required this.palname,
    required this.gender,
    required this.animalType,
    required this.breed,
    required this.imageUrl,
    required this.age,
    required this.weight,
    required this.description,
    required this.isVaccinated,
    required this.isTrained,
    required this.contactNumber,
    required this.city,
    required this.address,
    required this.timestamp,
    //required this.postid,
    this.availability = 'Available',
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'palname': palname,
      'gender':gender,
      'animeType': animalType,
      'breed': breed,
      'imageUrl': imageUrl,
      'age': age,
      'weight': weight,
      'isVaccinated': isVaccinated,
      'isTrained': isTrained,
      'contactNumber': contactNumber,
      'city': city,
      'address': address,
      'description': description,
      'timestamp': timestamp,
      'availability': availability,
      //'postid': postid,
    };
  }

  factory AdoptionPostModel.fromMap(Map<String, dynamic> map) {
    return AdoptionPostModel(
      email: map['email'] ?? '',
      palname: map['palname'] ?? '',
      gender: map['gender'] ?? '',
      animalType: map['animalType'] ?? '',
      breed: map['breed'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      age: map['age']?.toDouble() ?? 0.0,
      weight: map['weight']?.toDouble() ?? 0.0,
      isVaccinated: map['isVaccinated'] ?? '',
      isTrained: map['isTrained'] ?? '',
      contactNumber: map['contactNumber'] ?? 0,
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp'] ?? '',
      availability: map['availability'] ?? '',
      //postid: map['postid'] ?? '',
    );
  }

  AdoptionPostModel copyWith({
    String? email,
    String? palname,
    String? gender,
    String? animeType,
    String? breed,
    String? imageUrl,
    double? age,
    double? weight,
    String? description,
    String? isVaccinated,
    String? isTrained,
    int? contactNumber,
    String? city,
    String? address,
    String? availability,
  }) {
    return AdoptionPostModel(
      email: email ?? this.email,
      palname: palname ?? this.palname,
      gender: gender ?? this.gender,
      animalType: animeType ?? this.animalType,
      breed: breed ?? this.breed,
      imageUrl: imageUrl ?? this.imageUrl,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      isVaccinated: isVaccinated ?? this.isVaccinated,
      isTrained: isTrained ?? this.isTrained,
      contactNumber: contactNumber ?? this.contactNumber,
      city: city ?? this.city,
      address: address ?? this.address,
      availability: availability ?? this.availability,
      timestamp: timestamp,
      //postid: postid,
    );
  }
}
