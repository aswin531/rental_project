import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/datasources/local_storage_datasource.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseDataSource firebaseDataSource;
  final LocalStorageDatasource localStorageDatasource;

  AuthRepositoryImpl(
      {required this.firebaseDataSource, required this.localStorageDatasource});

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    debugPrint('signInWithEmailAndPassword called with email: $email');
    final user =
        await firebaseDataSource.signInWithEmailAndPassword(email, password);
    if (user != null) {
      final token = await user.getIdToken() ?? '';
      await localStorageDatasource.saveAuthToken(token);
      debugPrint('Email sign-in successful, token saved');
    } else {
      debugPrint('Email sign-in failed');
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    debugPrint('signInWithGoogle called');
    final user = await firebaseDataSource.signInWithGoogle();
    if (user != null) {
      await localStorageDatasource.saveAuthToken(await user.getIdToken() ?? "");
      debugPrint(
          'Google sign-in successful, token saved : ${user.getIdToken()}');
    } else {
      debugPrint('Google sign-in failed');
    }
    return user;
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    debugPrint('signUpWithEmailAndPassword called with email: $email');
    final user =
        await firebaseDataSource.signUpWithEmailAndPassword(email, password);
    if (user != null) {}
  }

  @override
  Future<void> signOut() async {
    debugPrint('signOut called');
    await firebaseDataSource.signOut();
    await localStorageDatasource.clearAuthToken();
    debugPrint('User signed out, token cleared');
  }

  @override
  User? getCurrentUser() {
    debugPrint('getCurrentUser called');
    return firebaseDataSource.getCurrentUser();
  }

  @override
  Future<void> saveAuthToken(String token) async {
    debugPrint('saveAuthToken called with token: $token');
    await localStorageDatasource.saveAuthToken(token);
  }

  @override
  Future<String?> getAuthToken() async {
    debugPrint('getAuthToken called');
    return localStorageDatasource.getAuthToken();
  }

  @override
  Future<void> clearAuthToken() async {
    await localStorageDatasource.clearAuthToken();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    debugPrint('verifyPhoneNumber called with phoneNumber: $phoneNumber');
    await firebaseDataSource.verifyPhoneNumber(phoneNumber);
  }

  @override
  Future<void> signInWithPhoneNumber(String smsCode) async {
    debugPrint('signInWithPhoneNumber called with smsCode: $smsCode');
    final user = await firebaseDataSource.signInWithPhoneNumber(smsCode);
    if (user != null) {
      final token = await user.getIdToken() ?? '';
      await localStorageDatasource.saveAuthToken(token);
      debugPrint('Phone number sign-in successful, token saved');
    } else {
      debugPrint('Phone number sign-in failed');
    }
  }
}
