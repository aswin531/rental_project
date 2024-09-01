import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/profile/data/model/userprofile_model.dart';

abstract class UserprofileDatasource {
  Future<void> saveuserProfile(UserProfileModel profile);
  Future<UserProfileModel?> getUserProfile(String userId);
  Future<void> updateUserProfile(UserProfileModel profile);
}

class UserProfileDataSourceImple implements UserprofileDatasource {
  final FirebaseFirestore firebaseFirestore;

  UserProfileDataSourceImple(this.firebaseFirestore);

  @override
  Future<void> saveuserProfile(UserProfileModel profile) async {
    await firebaseFirestore
        .collection('user_profiles')
        .doc(profile.userId)
        .set(profile.toJson());
  }

  @override
  Future<UserProfileModel?> getUserProfile(String userId) async {
    final doc =
        await firebaseFirestore.collection('user_profiles').doc(userId).get();
    if (doc.exists) {
      return UserProfileModel.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> updateUserProfile(UserProfileModel profile) async {
    await firebaseFirestore
        .collection('user_profiles')
        .doc(profile.userId)
        .update(profile.toJson());
  }
}
