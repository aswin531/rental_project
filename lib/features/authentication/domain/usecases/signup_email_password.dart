import 'package:rentit/features/authentication/data/repositories/authentication_repository.dart';
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthenticationRepository repository;

  SignUpWithEmailAndPasswordUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.signUpWithEmailAndPassword(email, password);
  }
}