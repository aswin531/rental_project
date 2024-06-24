import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/repositories/auth_repo_imple.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';

final getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(
      repositrory: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );

  getIt.registerLazySingleton<SignInWithEmailAndPassword>(
    () => SignInWithEmailAndPassword(
      repository: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );

  getIt.registerLazySingleton<SignUpWithEmailAndPassword>(
    () => SignUpWithEmailAndPassword(
      repository: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );

  getIt.registerLazySingleton<SignInWithPhoneNumber>(
    () => SignInWithPhoneNumber(
      repository: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );

  getIt.registerLazySingleton<SignOut>(
    () => SignOut(
      repository: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );

  getIt.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(
      repository: AuthRepositoryImpl(
        dataSource: FirebaseDataSource(
            firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()),
      ),
    ),
  );
}







// void setupDependencies() {
//   getIt.registerSingleton<SignInWithGoogle>(SignInWithGoogle());
//   getIt.registerSingleton<SignInWithEmailAndPassword>(SignInWithEmailAndPassword());
//   getIt.registerSingleton<SignUpWithEmailAndPassword>(SignUpWithEmailAndPassword());
//   getIt.registerSingleton<SignInWithPhoneNumber>(SignInWithPhoneNumber());
//   getIt.registerSingleton<SignOut>(SignOut());
//   getIt.registerSingleton<GetCurrentUser>(GetCurrentUser());
// }