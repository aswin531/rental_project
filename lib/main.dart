import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/constants/screen_util_setup.dart';
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
import 'package:rentit/features/rental/data/datasource/rental_datasource.dart';
import 'package:rentit/features/rental/data/repository/rental_repo_impl.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';
import 'package:rentit/features/rental/domain/usecases/get_user_rental.dart';
import 'package:rentit/features/rental/domain/usecases/rental_usecase.dart';
import 'package:rentit/features/rental/domain/usecases/update_request.dart';
import 'package:rentit/features/rental/presentation/bloc/mybooking_bloc/bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(CheckStatusEvent()),
        ),
        BlocProvider<CarBloc>(
            create: (_) => CarBloc(
                getcarUsecase:
                    GetcarUsecase(repository: _.read<CarRepository>()))),
        BlocProvider(
          create: (_) => RentalRequestBloc(
              createRentalRequest:
                  CreateRentalRequest(_.read<RentalRequestRepository>()),
              getUserRentalRequests:
                  GetUserRentalRequests(_.read<RentalRequestRepository>()),
              updateRentalRequestStatus:
                  UpdateRentalRequestStatus(_.read<RentalRequestRepository>())),
        ),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => TabBloc()),
        BlocProvider(
            create: (context) => BrandsBloc(
                getBrandUsecase: GetBrandUsecase(
                    carRepository: context.read<CarRepository>()),
                getCarsByBrandUsecase: GetCarsByBrandUsecase(
                    carRepository: context.read<CarRepository>()))),
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}


//context.read ==>> _.read<CarRepository>() is used to retrieve an instance of CarRepository from the dependency injection setup