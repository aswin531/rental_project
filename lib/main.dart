import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rentit/core/di/profile_dependencies.dart';
import 'package:rentit/core/helpers/background_task_scheduler.dart';
import 'package:rentit/core/helpers/notification_helper.dart';
import 'package:rentit/core/services/stripe_services.dart';
import 'package:rentit/features/home/domain/usecases/search_filter_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_bloc.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:rentit/features/profile/domain/usecases/profile_image_upload.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_getprofile_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_saveuser_usecase.dart';
import 'package:rentit/features/profile/domain/usecases/profile_setup_update.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:rentit/features/rental/domain/usecases/rental_car_return_completion.dart';
import 'package:rentit/features/rental/domain/usecases/update_car_availability_usecase.dart';
import 'package:rentit/features/returncar/data/datasource/return_car_datasource.dart';
import 'package:rentit/features/returncar/data/repository/return_car_repo_impl.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_confirm_usecases.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_initial_usecases.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_bloc.dart';
import 'package:rentit/utils/screen_util_setup.dart';
import 'package:rentit/core/di/dependency_injection.dart';
import 'package:rentit/core/router/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/bottomnav/presentation/bloc/navigation_bloc.dart';
import 'package:rentit/features/home/data/datasource/car_datasource.dart';
import 'package:rentit/features/home/data/repository/car_repos_impl.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';
import 'package:rentit/features/home/domain/usecases/carbybrand_usecase.dart';
import 'package:rentit/features/home/domain/usecases/getbrand_usecase.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/car/carbloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/rental/data/datasource/rental_datasource.dart';
import 'package:rentit/features/rental/data/repository/rental_repo_impl.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';
import 'package:rentit/features/rental/domain/usecases/get_user_rental.dart';
import 'package:rentit/features/rental/domain/usecases/rental_usecase.dart';
import 'package:rentit/features/rental/domain/usecases/update_request.dart';
import 'package:rentit/features/rental/presentation/bloc/tab_blloc/bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await stripeSetUp();
  await profileInit();
  await initializeNotifications();
  tz.initializeTimeZones();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize dependencies
  await init();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => sl<AuthRepository>(),
        ),
        RepositoryProvider<CarRepository>(
          create: (_) => CarReposImpl(
              remoteDataSource:
                  CarRemoteDataSourceImpl(FirebaseFirestore.instance)),
        ),
        RepositoryProvider<RentalRequestRepository>(
          create: (_) => RentalRequestRepositoryImpl(
            FirebaseRentalRequestDataSource(FirebaseFirestore.instance),
          ),
        ),
        RepositoryProvider<SaveUserProfileUsecase>(
          create: (_) => sl<SaveUserProfileUsecase>(),
        ),
        RepositoryProvider<GetUserProfile>(
          create: (_) => sl<GetUserProfile>(),
        ),
        RepositoryProvider<UpdateUserProfile>(
          create: (_) => sl<UpdateUserProfile>(),
        ),
        RepositoryProvider<UploadProfileImageUsecase>(
          create: (_) => sl<UploadProfileImageUsecase>(),
        ),
        RepositoryProvider<UploadProfileImageUsecase>(
          create: (_) => sl<UploadProfileImageUsecase>(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(CheckStatusEvent()),
        ),
        BlocProvider<CarBloc>(
            create: (_) => CarBloc(
              filterCarsUsecase: FilterCarsUsecase(carRepository: _.read<CarRepository>()),
            searchCarsUsecase: SearchCarsUsecase(carRepository: _.read<CarRepository>()),
                getCarsStreamUseCase:
                    GetCarsStreamUseCase(repository: _.read<CarRepository>()))),
        BlocProvider(
          create: (_) => RentalRequestBloc(rentalRequestRepository: _.read<RentalRequestRepository>(),
              completeReturnProcessUsecase: CompleteReturnProcessUsecase(
                  _.read<RentalRequestRepository>()),
              createRentalRequest:
                  CreateRentalRequest(_.read<RentalRequestRepository>()),
              getUserRentalRequests:
                  GetUserRentalRequests(_.read<RentalRequestRepository>()),
              updateRentalRequestStatus:
                  UpdateRentalRequestStatus(_.read<RentalRequestRepository>()),
              updateCarAvailabilityUsecase: UpdateCarAvailabilityUsecase(
                  _.read<RentalRequestRepository>())),
        ),
        BlocProvider(
            create: (context) => BrandsBloc(
                getBrandUsecase: GetBrandUsecase(
                    carRepository: context.read<CarRepository>()),
                getCarsByBrandUsecase: GetCarsByBrandUsecase(
                    carRepository: context.read<CarRepository>()))),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => TabBloc()),
        BlocProvider(create: (context) => SelectedCarBloc()),
        BlocProvider(create: (_) => sl<LocationMapBloc>()),
        BlocProvider<PaymentBloc>(
          create: (context) => sl<PaymentBloc>(),
        ),
        BlocProvider<ProfileSetupBloc>(
          create: (context) => ProfileSetupBloc(
              firebaseAuth: GetIt.I<FirebaseAuth>(),
              saveUserProfileUsecase: context.read<SaveUserProfileUsecase>(),
              getUserProfileUsecase: context.read<GetUserProfile>(),
              uploadProfileImageUsecase:
                  context.read<UploadProfileImageUsecase>(),
              updateUserProfileUsecase: context.read<UpdateUserProfile>()),
        ),
        BlocProvider(
          create: (_) => CarReturnBloc(
            returnCarInitialUsecases: ReturnCarInitialUsecases(
              CarReturnRepositoryImpl(
                ReturnCarDataSourceImpl(FirebaseFirestore.instance),
              ),
            ),
            returnCarConfirmUsecase: ReturnCarConfirmUsecase(
              CarReturnRepositoryImpl(
                ReturnCarDataSourceImpl(FirebaseFirestore.instance),
              ),
            ),
          ),
        )
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return ScreenUtilSetup(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        title: 'Rent IT',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
