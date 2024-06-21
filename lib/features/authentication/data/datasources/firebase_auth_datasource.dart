// lib/features/authentication/data/datasources/firebase_auth_data_source.dart

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:rentit/features/authentication/domain/entity/user_entity.dart' as domain;

class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<domain.User> signInWithEmailAndPassword(String email, String password) async {
    firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    firebase_auth.User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      return domain.User(
        firebaseUser.uid,
        email: firebaseUser.email,
        password: password,
      );
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<domain.User> signUpWithEmailAndPassword(String email, String password) async {
    firebase_auth.UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    firebase_auth.User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      return domain.User(
        firebaseUser.uid,
        email: firebaseUser.email,
        password: password,
      );
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
