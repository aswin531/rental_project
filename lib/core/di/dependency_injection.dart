import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/datasources/local_storage_datasource.dart';
import 'package:rentit/features/authentication/data/repositories/auth_repo_imple.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
// FirebaseAuth
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
// GoogleSignIn
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => googleSignIn);

  // DataSources
  sl.registerLazySingleton<LocalStorageDatasource>(
    () => SharedPreferencesDataSource(sl()),
  );

  sl.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSource(
        firebaseAuth: sl<FirebaseAuth>(), googleSignIn: sl<GoogleSignIn>()),
  );

// Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      firebaseDataSource: sl<FirebaseDataSource>(), localStorageDatasource: sl<LocalStorageDatasource>()));

//Usecases
  sl.registerLazySingleton(() => SignInWithGoogle(repositrory: sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPassword(repository: sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => SignInWithPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => SignOut(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repository: sl()));
  sl.registerLazySingleton(() => SaveAuthToken(repository: sl()));
  sl.registerLazySingleton(() => GetAuthToken(repository: sl()));
  sl.registerLazySingleton(() => ClearAuthToken(repository: sl()));

//BLoC
  sl.registerFactory(() => AuthBloc(
        signInWithGoogle: sl(),
        signInWithEmailAndPassword: sl(),
        signUpWithEmailAndPassword: sl(),
        verifyPhoneNumber: sl(),
        signInWithPhoneNumber: sl(),
        signOut: sl(),
        getCurrentUser: sl(),
        saveAuthToken: sl(),
        getAuthToken: sl(),
        clearAuthToken: sl(),
      ));
}















// Lazy singleton means the instance 
//will be created only once when it is needed for the first time.
//FirebaseDataSource and LocalStorageDataSource=> dependencies required by AuthRepositoryImpl