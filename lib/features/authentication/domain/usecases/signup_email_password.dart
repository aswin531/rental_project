import 'package:rentit/features/authentication/data/repositories/authentication_repository.dart';
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthenticationRepository repository;

  SignUpWithEmailAndPasswordUseCase(this.repository);

  Future<User> signUpWithEmailAndPassword(
    String name,
    String lastName,
    String email,
    String password,
    String confirmPassword
  ) async {
    return await repository.signUpWithEmailAndPassword(name,lastName,email, password,confirmPassword);
  }
}
