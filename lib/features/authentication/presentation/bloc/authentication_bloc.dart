import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/services/user_services.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final VerifyPhoneNumber verifyPhoneNumber;
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SaveAuthToken saveAuthToken;
  final GetAuthToken getAuthToken;
  final ClearAuthToken clearAuthToken;
  final SaveUserProfileUsecase saveUserProfileUsecase;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.verifyPhoneNumber,
    required this.signInWithPhoneNumber,
    required this.signOut,
    required this.getCurrentUser,
    required this.saveAuthToken,
    required this.getAuthToken,
    required this.clearAuthToken,
    required this.saveUserProfileUsecase,
  }) : super(AuthInitial()) {
    on<FetchCurrentUser>((event, emit) {
      final user = getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnAuthenticated());
      }
    });
    //=====================Check-Status-Event========================
    on<CheckStatusEvent>((event, emit) async {
      final user = getCurrentUser();
      final token = await getAuthToken();
      if (user != null && token != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    //=====================SignIn-Google-Event========================
    on<SignInGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithGoogle();
        if (user != null) {
          final token = await user.getIdToken();
          await saveAuthToken(token ?? '');
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignIn-EmailPassword-Event========================
    on<SignInEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signInWithEmailAndPassword(event.email, event.password);
        final token = await getAuthToken();
        await saveAuthToken(token ?? '');
        final user = getCurrentUser();
        final userId = user?.uid;
        final userService = UserService();
        userService.setUserId(userId ?? '');
        debugPrint('User ID set:$userId');
        emit(AuthAuthenticated(user!));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignUp-EmailPassword-Event========================
    on<SignUpEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUpWithEmailAndPassword(event.email, event.password);
        final token = await getAuthToken();
        await saveAuthToken(token ?? '');
        final user = getCurrentUser();

        if (user != null) {
          emit(AuthProfileIncomplete(user));
        } else {
          emit(AuthUnAuthenticated());
        }
        if (user != null) {
          emit(AuthProfileIncomplete(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Send-PhoneCode-Event========================
    on<SendPhoneCodeEvent>((event, emit) async {
      try {
        await verifyPhoneNumber(event.phoneNumber);
        emit(CodeSentState());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Verify-PhoneCode-Event========================
    on<VerifyPhoneCodeEvent>((event, emit) async {
      try {
        final user = getCurrentUser();

        //final userCredential = await signInWithPhoneNumber?.call(event.smsCode);
        emit(AuthAuthenticated(user!));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignOut-Event========================
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOut();
        await clearAuthToken();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignOut-Event========================
    on<CompleteProfileSetupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = getCurrentUser();
        if (user != null) {
          final userProfile = UserProfile(
            userId: user.uid,
            name: event.profileData['name'],
            job: event.profileData['job'],
            location: event.profileData['location'],
            cityState: event.profileData['cityState'],
            phone: event.profileData['phone'],
            license: event.profileData['license'],
            dob: DateTime.parse(event.profileData['dob']),
            homeLocation: event.profileData['homeLocation'],
            imageUrl: event.profileData['imageUrl'],
          );
          await saveUserProfileUsecase(userProfile);
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
