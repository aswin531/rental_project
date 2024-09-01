

import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';

class GetUserProfile {
  final UserProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfile?> call(String userId) async {
    return await repository.getUserProfile(userId);
  }
}