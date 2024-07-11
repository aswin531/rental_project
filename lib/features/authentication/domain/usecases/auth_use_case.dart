import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';

//-----------SignIN Google-----------------

class SignInWithGoogle {
  final AuthRepository repositrory;
  SignInWithGoogle({required this.repositrory});

  Future<User?> call() async {
    return await repositrory.signInWithGoogle();
  }
}

//-----------SignIN Email & Password-----------------

class SignInWithEmailAndPassword {
  final AuthRepository repository;
  SignInWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}

//-----------SignUp Email & Password----------------

class SignUpWithEmailAndPassword {
  final AuthRepository repository;
  SignUpWithEmailAndPassword({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}

//-----------SignUp Phone-Number----------------

class VerifyPhoneNumber {
  final AuthRepository repository;

  VerifyPhoneNumber({required this.repository});

  Future<void> call(String phoneNumber) async {
    return await repository.verifyPhoneNumber(phoneNumber);
  }
}

class SignInWithPhoneNumber {
  final AuthRepository repository;

  SignInWithPhoneNumber({required this.repository});

  Future<void> call(String smsCode) async {
    await repository.signInWithPhoneNumber(smsCode);
  }
}

//-----------Sign-Out----------------

class SignOut {
  final AuthRepository repository;
  SignOut({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}

//-----------Get User----------------

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser({required this.repository});

  User? call() {
    return repository.getCurrentUser();
  }
}

//-----------Get User----------------
class ForgetPassword {
  final AuthRepository repository;
  ForgetPassword({required this.repository});
}
