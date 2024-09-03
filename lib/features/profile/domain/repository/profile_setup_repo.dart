import 'dart:io';

import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(UserProfile profile);
  Future<UserProfile?> getUserProfile(String userId);
  Future<void> updateUserProfile(UserProfile profile);
  Future<String> uploadProfileImage(File profile);
}
