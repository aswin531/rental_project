import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  User? getCurrentUser() => dataSource.getCurrentUser();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) =>
      dataSource.signInWithEmailAndPassword(email, password);

  @override
  Future<User?> signInWithGoogle() => dataSource.signInWithGoogle();

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber, String smsCode) =>
      dataSource.signInWithPhoneNumber(smsCode);

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) =>
      dataSource.signUpWithEmailAndPassword(email, password);
}
