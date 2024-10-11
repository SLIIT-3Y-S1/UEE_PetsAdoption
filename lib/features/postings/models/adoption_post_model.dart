class AdoptionPostModel {
  final String userid;
  final String palname;
  final String animeType;
  final String breed;
  final String imageUrl;
  final double age;
  final double weight;
  final String isVaccinated;
  final String isTrained;
  final int contactNumber;
  final String location;
  final String description;

  AdoptionPostModel({
    required this.userid,
    required this.palname,
    required this.animeType,
    required this.breed,
    required this.imageUrl,
    required this.age,
    required this.weight,
    required this.isVaccinated,
    required this.isTrained,
    required this.contactNumber,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'palname': palname,
      'animeType': animeType,
      'breed': breed,
      'imageUrl': imageUrl,
      'age': age,
      'weight': weight,
      'isVaccinated': isVaccinated,
      'isTrained': isTrained,
      'contactNumber': contactNumber,
      'location': location,
      'description': description,
    };
  }

  factory AdoptionPostModel.fromMap(Map<String, dynamic> map) {
    return AdoptionPostModel(
      userid: map['userid'] ?? '',
      palname: map['palname'] ?? '',
      animeType: map['animeType'] ?? '',
      breed: map['breed'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      age: map['age']?.toDouble() ?? 0.0,
      weight: map['weight']?.toDouble() ?? 0.0,
      isVaccinated: map['isVaccinated'] ?? '',
      isTrained: map['isTrained'] ?? '',
      contactNumber: map['contactNumber'] ?? 0,
      location: map['location'] ?? '',
      description: map['description'] ?? '',
    );
  }

  AdoptionPostModel copyWith({
    String? userid,
    String? palname,
    String? animeType,
    String? breed,
    String? imageUrl,
    double? age,
    double? weight,
    String? isVaccinated,
    String? isTrained,
    int? contactNumber,
    String? location,
    String? description,
  }) {
    return AdoptionPostModel(
      userid: userid ?? this.userid,
      palname: palname ?? this.palname,
      animeType: animeType ?? this.animeType,
      breed: breed ?? this.breed,
      imageUrl: imageUrl ?? this.imageUrl,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      isVaccinated: isVaccinated ?? this.isVaccinated,
      isTrained: isTrained ?? this.isTrained,
      contactNumber: contactNumber ?? this.contactNumber,
      location: location ?? this.location,
      description: description ?? this.description,
    );
  }


  
}
