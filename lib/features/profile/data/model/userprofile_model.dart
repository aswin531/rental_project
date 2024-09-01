// lib/data/models/user_profile_model.dart

import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.userId,
    required super.name,
    required super.location,
    required super.cityState,
    required super.phone,
    required super.license,
    required super.dob,
    required super.homeLocation,
    super.imageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      name: json['name'],
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