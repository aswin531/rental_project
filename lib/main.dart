import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/core/constants/screen_util_setup.dart';
import 'package:rentit/core/navigation/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentit/features/authentication/data/datasources/firebase_auth_datasource.dart';
import 'package:rentit/features/authentication/data/repositories/auth_repo_imple.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/home/data/datasource/car_datasource.dart';
import 'package:rentit/features/home/data/repository/car_repos_impl.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/carbloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            dataSource: FirebaseDataSource(
                firebaseAuth: FirebaseAuth.instance,
                googleSignIn: GoogleSignIn()),
          ),
        ),
        RepositoryProvider<CarRepository>(
          create: (_) => CarReposImpl(
              remoteDataSource:
                  CarRemoteDataSourceImpl(FirebaseFirestore.instance)),
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
                signInWithEmailAndPassword: SignInWithEmailAndPassword(
                    repository: _.read<AuthRepository>()),
                signInWithGoogle:
                    SignInWithGoogle(repositrory: _.read<AuthRepository>()),
                signUpWithEmailAndPassword: SignUpWithEmailAndPassword(
                    repository: _.read<AuthRepository>()),
                signInWithPhoneNumber:
                    SignInWithPhoneNumber(repository: _.read<AuthRepository>()),
                signOut: SignOut(repository: _.read<AuthRepository>()))),
        BlocProvider<CarBloc>(
            create: (_) => CarBloc(
                getcarUsecase:
                    GetcarUsecase(repository: _.read<CarRepository>())))
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilSetup(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}


//context.read ==>> _.read<CarRepository>() is used to retrieve an instance of CarRepository from the dependency injection setup