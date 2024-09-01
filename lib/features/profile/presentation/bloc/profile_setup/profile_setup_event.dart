abstract class ProfileSetupEvent {}

class SubmitProfileSetup extends ProfileSetupEvent {
  final String name;
  final String location;
  final String cityState;
  final String phone;
  final String license;
  final String dob;
  final String homeLocation;

  SubmitProfileSetup({
    required this.name,
    required this.location,
    required this.cityState,
    required this.phone,
    required this.license,
    required this.dob,
    required this.homeLocation,
  });
}
