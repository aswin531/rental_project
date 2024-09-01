import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final SaveUserProfileUsecase saveUserProfileUsecase;
  final FirebaseAuth firebaseAuth;
  final String userId;

  ProfileSetupBloc(this.userId, this.firebaseAuth,
      {required this.saveUserProfileUsecase,})
      : super(ProfileSetupInitial()) {
    on<SubmitProfileSetup>(onSubmitProfileSetup);
  }
  Future<void> onSubmitProfileSetup(
      SubmitProfileSetup event, Emitter<ProfileSetupState> emit) async {
    emit(ProfileSetupLoading());
    try {
      final currentUser = firebaseAuth.currentUser;
      debugPrint(currentUser?.uid.toString());
      final userProfile = UserProfile(
          userId: currentUser!.uid.toString(),
          name: event.name,
          location: event.location,
          cityState: event.cityState,
          phone: event.phone,
          license: event.license,
          dob: event.dob as DateTime,
          homeLocation: event.homeLocation);
      await saveUserProfileUsecase.call(userProfile);
      emit(ProfileSetupSuccess());
    } catch (e) {
      emit(ProfileSetupError(e.toString()));
    }
  }
}
