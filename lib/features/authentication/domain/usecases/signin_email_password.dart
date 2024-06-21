
import 'package:rentit/features/authentication/data/repositories/authentication_repository.dart';
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthenticationRepository repository;

  SignInWithEmailAndPasswordUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}
