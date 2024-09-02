import 'package:rentit/features/profile/data/datasource/userprofile_datasource.dart';
import 'package:rentit/features/profile/data/model/userprofile_model.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';

class UserprofilerepoImple implements UserProfileRepository {
  final UserprofileDatasource userprofileDatasource;
  UserprofilerepoImple(this.userprofileDatasource);

  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    final userProfileModel = UserProfileModel(
        userId: profile.userId,
        name: profile.name,
        job: profile.job,
        location: profile.location,
        cityState: profile.cityState,
        phone: profile.phone,
        license: profile.license,
        dob: profile.dob,
        homeLocation: profile.homeLocation);

    await userprofileDatasource.saveuserProfile(userProfileModel);
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    final userProfileModel = await userprofileDatasource.getUserProfile(userId);
    return userProfileModel;
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    final userProfileModel = UserProfileModel(
      userId: profile.userId,
      name: profile.name,
      job: profile.job,
      location: profile.location,
      cityState: profile.cityState,
      phone: profile.phone,
      license: profile.license,
      dob: profile.dob,
      homeLocation: profile.homeLocation,
      imageUrl: profile.imageUrl,
    );
    await userprofileDatasource.updateUserProfile(userProfileModel);
  }
}
