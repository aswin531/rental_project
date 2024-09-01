// import 'package:rentit/core/di/dependency_injection.dart';
// import 'package:rentit/features/profile/domain/repository/profile_setup_repo.dart';
// import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
// import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';

// Future<void> profileInit() async {
//  // Register Repositories
//   sl.registerLazySingleton<UserProfileRepository>(() => UserProfileRepositoryImpl());

//   // Register Use Cases
//   sl.registerLazySingleton<SaveUserProfileUsecase>(
//       () => SaveUserProfileUsecase(sl<UserProfileRepository>()));

//   // Register Blocs
//   sl.registerFactory<ProfileSetupBloc>(() => ProfileSetupBloc(saveUserProfileUsecase: sl<SaveUserProfileUsecase>
//       ));
// }