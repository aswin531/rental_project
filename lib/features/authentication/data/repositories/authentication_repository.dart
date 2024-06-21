import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

abstract class AuthenticationRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String name, String lastName,
      String email, String password, confirmPassword);
  Future<void> signOut();
}
