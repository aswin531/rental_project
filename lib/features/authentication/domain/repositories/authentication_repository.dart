
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

abstract class AuthenticationRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}