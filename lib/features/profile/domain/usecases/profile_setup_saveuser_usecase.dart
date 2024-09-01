
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';

class SaveUserProfileUsecase {
  final UserProfileRepository repository;

  SaveUserProfileUsecase(this.repository);

  Future<void> call(UserProfile profile) async {
    await repository.saveUserProfile(profile);
  }
}



