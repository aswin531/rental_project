import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/features/profile/data/model/userprofile_model.dart';

abstract class UserprofileDatasource {
  Future<void> saveuserProfile(UserProfileModel profile);
  Future<UserProfileModel?> getUserProfile(String userId);
  Future<void> updateUserProfile(UserProfileModel profile);
    Future<String> uploadProfileImage(File imageFile);

}

class UserProfileDataSourceImple implements UserprofileDatasource {
  final FirebaseFirestore firebaseFirestore;
    final FirebaseStorage firebaseStorage;


  UserProfileDataSourceImple(this.firebaseFirestore,this.firebaseStorage);

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
  
  @override
  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final storageRef = firebaseStorage
          .ref()
          .child('profile_images/${imageFile.uri.pathSegments.last}');
      final uploadTask = await storageRef.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
