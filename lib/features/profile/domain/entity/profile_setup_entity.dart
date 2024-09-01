
class UserProfile {
  final String userId;
  final String name;
  final String location;
  final String cityState;
  final String phone;
  final String license;
  final DateTime dob;
  final String homeLocation;
  final String? imageUrl;

  UserProfile({
    required this.userId,
    required this.name,
    required this.location,
    required this.cityState,
    required this.phone,
    required this.license,
    required this.dob,
    required this.homeLocation,
    this.imageUrl,
  });
}