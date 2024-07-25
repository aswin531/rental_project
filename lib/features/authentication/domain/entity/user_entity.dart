class UserEntity {
  String? id;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? name;
  final String? lastName;

  UserEntity(this.id, this.phoneNumber, this.name, this.lastName, {required this.email, required this.password});
}
