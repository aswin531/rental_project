import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  AuthBloc(
      {required this.signInWithGoogle,
      required this.signInWithEmailAndPassword,
      required this.signUpWithEmailAndPassword,
      required this.signInWithPhoneNumber,
      required this.signOut,
      required this.getCurrentUser})
      : super(AuthInitial()) {
//=====================SigIn-Google-Event========================
    on<SignInGoogleEvent>(
      (event, emit) async {
        try {
          await signInWithGoogle();
          emit(AuthAuthenticated());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      },
    );

//=====================SigIn-EmailPassword-Event========================
    on<SigInEmailPasswordEvent>((event, emit) async {
      try {
        await signInWithEmailAndPassword(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SigUp-EmailPassword-Event========================
    on<SignUpEmailPasswordEvent>((event, emit) async {
      try {
        await signUpWithEmailAndPassword(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SigIn-PhoneNumber-Event========================
    on<SignInPhoneEvent>((event, emit) async {
      try {
        await signInWithPhoneNumber(event.phoneNumber, event.smsCode);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SignOut-Event========================
    on<SignOutEvent>((event, emit) async {
      try {
        await signOut();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SignOut-Event========================
    on<CheckStatusEvent>((event, emit) async {
      final user = getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    });
  }
}
