import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/usecases/profile_image_upload.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_getprofile_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_update.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final SaveUserProfileUsecase saveUserProfileUsecase;
  final GetUserProfile getUserProfileUsecase;
  final UpdateUserProfile updateUserProfileUsecase;
  final UploadProfileImageUsecase uploadProfileImageUsecase;

  final FirebaseAuth firebaseAuth;
  PlatformFile? selectedImage;

  ProfileSetupBloc(
      {required this.saveUserProfileUsecase,
      required this.getUserProfileUsecase,
      required this.updateUserProfileUsecase,
      required this.firebaseAuth,
      required this.uploadProfileImageUsecase})
      : super(ProfileSetupInitial()) {
    on<SubmitProfileSetup>(onSubmitProfileSetup);
    on<ProfileImagePickedEvent>(onPickProfileImage);
    on<FetchUserProfile>(onFetchUserProfile);
    on<UpdateProfileEvent>(onUpdateProfile);
  }
  Future<void> onSubmitProfileSetup(
      SubmitProfileSetup event, Emitter<ProfileSetupState> emit) async {
    emit(ProfileSetupLoading());
    try {
      final currentUser = firebaseAuth.currentUser;
      String imageUrl =
          await uploadProfileImageUsecase.call(File(event.profileImage!.path!));

      debugPrint("Image URL **/**/*/*/*/*/*/*/*/*/ $imageUrl");
      final userProfile = UserProfile(
          userId: currentUser!.uid.toString(),
          name: event.name,
          job: event.job,
          location: event.location,
          cityState: event.cityState,
          phone: event.phone,
          license: event.license,
          dob: event.dob,
          homeLocation: event.homeLocation,
          imageUrl: imageUrl);
      await saveUserProfileUsecase.call(userProfile);
      emit(ProfileSetupSuccess());
    } catch (e) {
      emit(ProfileSetupError(e.toString()));
    }
  }

  Future<void> onPickProfileImage(
      ProfileImagePickedEvent event, Emitter<ProfileSetupState> emit) async {
    selectedImage = event.file;
    emit(ProfileImagePickedState(selectedImage!));
  }

  Future<void> onFetchUserProfile(
      FetchUserProfile event, Emitter<ProfileSetupState> emit) async {
    emit(ProfileSetupLoading());
    try {
      final currentUser = firebaseAuth.currentUser;
      final userProfile = await getUserProfileUsecase.call(currentUser!.uid);
      if (userProfile != null) {
        emit(ProfileSetupLoaded(
            userProfile)); 
      } else {
        emit(const ProfileSetupError('User profile not found'));
      }
    } catch (e) {
      emit(ProfileSetupError(e.toString()));
    }
  }

  Future<void> onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileSetupState> emit) async {
    emit(ProfileSetupLoading());
    try {
      await updateUserProfileUsecase.call(event.profile);
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }
}
