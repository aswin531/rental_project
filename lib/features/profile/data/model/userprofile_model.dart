import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.userId,
    required super.name,
    required super.job,
    required super.location,
    required super.cityState,
    required super.phone,
    required super.license,
    required super.dob,
    required super.homeLocation,
    required super.imageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      name: json['name'],
      job: json['job'],
      location: json['location'],
      cityState: json['cityState'],
      phone: json['phone'],
      license: json['license'],
      dob: DateTime.parse(json['dob']),
      homeLocation: json['homeLocation'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'job': job,
      'location': location,
      'cityState': cityState,
      'phone': phone,
      'license': license,
      'dob': dob.toIso8601String(),
      'homeLocation': homeLocation,
      'imageUrl': imageUrl,
    };
  }
}
