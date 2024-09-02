import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();

  @override
  List<Object?> get props => [];
}
class ProfileSetupInitial extends ProfileSetupState{}

class ProfileSetupLoading extends ProfileSetupState {}
class ProfileSetupSuccess extends ProfileSetupState {}

class ProfileSetupError extends ProfileSetupState {
  final String message;
  const ProfileSetupError(this.message);
}


class ProfileImagePickedState extends ProfileSetupState {
  final PlatformFile file;

  const ProfileImagePickedState(this.file);

  @override
  List<Object?> get props => [file];
}

class ProfileSetupLoaded extends ProfileSetupState {
  final UserProfile userProfile;

  const ProfileSetupLoaded(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class ProfileUpdateSuccess extends ProfileSetupState {}

class ProfileUpdateError extends ProfileSetupState {
  final String message;

  const ProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}