import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class UserModel {
  String? id;
  final String? email;
  //final String? password;
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
