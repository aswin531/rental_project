abstract class ProfileSetupState{}

class ProfileSetupInitial extends ProfileSetupState{}

class ProfileSetupLoading extends ProfileSetupState {}
class ProfileSetupSuccess extends ProfileSetupState {}

class ProfileSetupError extends ProfileSetupState {
  final String message;
  ProfileSetupError(this.message);
}