import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class UserModel {
  String? id;
  final String? email;
  final String? phoneNumber;
  final String? name;
  final String? lastName;

  UserModel(
      {required this.id,
      required this.phoneNumber,
      required this.name,
      required this.lastName,
      required this.email});

//convert User(entity) to UserModel
  UserModel.fromEntity(UserEntity user)
      : id = user.id,
        name = user.name,
        lastName = user.lastName,
        email = user.email,
        phoneNumber = user.phoneNumber;

// Json to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber']);
  }

// UserModel to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phoneNumber //==//
    };
  }
}


class UserDetails {
  String? fullName;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? residentialAddress;
  String? countryState;
  String? preferredCarType;
  String? profileImagePath;

  UserDetails({
    this.fullName,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.residentialAddress,
    this.countryState,
    this.preferredCarType,
    this.profileImagePath,
  });

  // Convert UserDetails to a Map
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'email': email,
      'residentialAddress': residentialAddress,
      'countryState': countryState,
      'preferredCarType': preferredCarType,
      'profileImagePath': profileImagePath,
    };
  }

  // Create UserDetails from a Map
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      fullName: map['fullName'],
      dateOfBirth: map['dateOfBirth'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      residentialAddress: map['residentialAddress'],
      countryState: map['countryState'],
      preferredCarType: map['preferredCarType'],
      profileImagePath: map['profileImagePath'],
    );
  }

  // Helper method to update fields
  void updateFrom(UserDetails other) {
    fullName = other.fullName ?? fullName;
    dateOfBirth = other.dateOfBirth ?? dateOfBirth;
    phoneNumber = other.phoneNumber ?? phoneNumber;
    email = other.email ?? email;
    residentialAddress = other.residentialAddress ?? residentialAddress;
    countryState = other.countryState ?? countryState;
    preferredCarType = other.preferredCarType ?? preferredCarType;
    profileImagePath = other.profileImagePath ?? profileImagePath;
  }
}
