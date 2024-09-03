import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/core/di/dependency_injection.dart';
import 'package:rentit/features/profile/data/datasource/userprofile_datasource.dart';
import 'package:rentit/features/profile/data/repository/userprofilerepo_imple.dart';
import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';
import 'package:rentit/features/profile/domain/usecases/profile_image_upload.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_getprofile_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_update.dart';

Future<void> profileInit() async {
  // Data sources
  sl.registerLazySingleton<UserprofileDatasource>(
    () => UserProfileDataSourceImple(
        FirebaseFirestore.instance, FirebaseStorage.instance),
  );

  // Repositories
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserprofilerepoImple(sl<UserprofileDatasource>()),
  );

  // Use cases
  sl.registerLazySingleton<SaveUserProfileUsecase>(
    () => SaveUserProfileUsecase(sl<UserProfileRepository>()),
  );
  sl.registerLazySingleton<GetUserProfile>(
    () => GetUserProfile(sl<UserProfileRepository>()),
  );
  sl.registerLazySingleton<UpdateUserProfile>(
    () => UpdateUserProfile(sl<UserProfileRepository>()),
  );

  sl.registerLazySingleton<UploadProfileImageUsecase>(
      () => UploadProfileImageUsecase(sl()));

  //UploadProfileImageUsecase
}
