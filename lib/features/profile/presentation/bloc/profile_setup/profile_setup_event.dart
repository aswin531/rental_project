import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';

abstract class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object?> get props => [];
}

class SubmitProfileSetup extends ProfileSetupEvent {
  final String name;
  final String job;
  final String location;
  final String cityState;
  final String phone;
  final String license;
  final DateTime dob;
  final String homeLocation;
  final PlatformFile? profileImage;

  const SubmitProfileSetup({
    required this.name,
    required this.job,
    required this.location,
    required this.cityState,
    required this.phone,
    required this.license,
    required this.dob,
    required this.homeLocation,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
        name,
        job,
        location,
        cityState,
        phone,
        license,
        dob,
        homeLocation,
        profileImage,
      ];
}

class ProfileImagePickedEvent extends ProfileSetupEvent {
  final PlatformFile file;

  const ProfileImagePickedEvent(this.file);
}

class FetchUserProfile extends ProfileSetupEvent {
  final String userId;

  const FetchUserProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateProfileEvent extends ProfileSetupEvent {
  final UserProfile profile;

  const UpdateProfileEvent(this.profile);

  @override
  List<Object?> get props => [profile];
}
