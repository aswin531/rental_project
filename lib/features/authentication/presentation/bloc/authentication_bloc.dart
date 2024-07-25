import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final VerifyPhoneNumber verifyPhoneNumber;
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final SaveAuthToken saveAuthToken;
  final GetAuthToken getAuthToken;
  final ClearAuthToken clearAuthToken;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.verifyPhoneNumber,
    required this.signInWithPhoneNumber,
    required this.signOut,
    required this.getCurrentUser,
    required this.saveAuthToken,
    required this.getAuthToken,
    required this.clearAuthToken,
  }) : super(AuthInitial()) {
    //=====================Check-Status-Event========================
    on<CheckStatusEvent>((event, emit) async {
      final user = getCurrentUser();
      final token = await getAuthToken();
      if (user != null && token != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    //=====================SignIn-Google-Event========================
    on<SignInGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInWithGoogle();
        if (user != null) {
          final token = await user.getIdToken();
          await saveAuthToken(token ?? '');
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignIn-EmailPassword-Event========================
    on<SignInEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signInWithEmailAndPassword(event.email, event.password);
        final token = await getAuthToken();
        await saveAuthToken(token ?? '');
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignUp-EmailPassword-Event========================
    on<SignUpEmailPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUpWithEmailAndPassword(event.email, event.password);
        final token = await getAuthToken();
        await saveAuthToken(token ?? '');
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Send-PhoneCode-Event========================
    on<SendPhoneCodeEvent>((event, emit) async {
      try {
        await verifyPhoneNumber(event.phoneNumber);
        emit(CodeSentState());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Verify-PhoneCode-Event========================
    on<VerifyPhoneCodeEvent>((event, emit) async {
      try {
        //final userCredential = await signInWithPhoneNumber?.call(event.smsCode);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================SignOut-Event========================
    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOut();
        await clearAuthToken();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
