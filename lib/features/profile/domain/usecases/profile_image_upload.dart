import 'dart:io';

import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';

class UploadProfileImageUsecase {
  final UserProfileRepository userProfileRepository;

  UploadProfileImageUsecase(this.userProfileRepository);

  Future<String> call(File imageFile) {
    return userProfileRepository.uploadProfileImage(imageFile);
  }
}
