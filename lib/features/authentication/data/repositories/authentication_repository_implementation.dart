import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/repositories/authentication_repository.dart';
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  late final FirebaseAuthDataSource _dataSource;

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    return await _dataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<User> signUpWithEmailAndPassword(String name, String lastName,
      String email, String password, confirmPassword) async {
    return await _dataSource.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }
}
