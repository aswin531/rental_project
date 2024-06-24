import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/usecases/auth_use_case.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, Authstate> {
  final SignInWithGoogle? signInWithGoogle;
  final SignInWithEmailAndPassword? signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword? signUpWithEmailAndPassword;
  final VerifyPhoneNumber? verifyPhoneNumber;
  final SignInWithPhoneNumber? signInWithPhoneNumber;
  final SignOut? signOut;
  final GetCurrentUser? getCurrentUser;
  AuthBloc(
      {this.signInWithGoogle,
      this.signInWithEmailAndPassword,
      this.signUpWithEmailAndPassword,
      this.verifyPhoneNumber,
      this.signInWithPhoneNumber,
      this.signOut,
      this.getCurrentUser})
      : super(AuthInitial()) {
//=====================SigIn-Google-Event========================
    on<SignInGoogleEvent>(
      (event, emit) async {
        try {
          await signInWithGoogle!();
          emit(AuthAuthenticated());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      },
    );

//=====================SigIn-EmailPassword-Event========================
    on<SigInEmailPasswordEvent>((event, emit) async {
      try {
        await signInWithEmailAndPassword!(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SigUp-EmailPassword-Event========================
    on<SignUpEmailPasswordEvent>((event, emit) async {
      try {
        await signUpWithEmailAndPassword!(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    //=====================Send-PhoneCode-Event========================
on<SendPhoneCodeEvent>((event, emit) async {
      try {
        await verifyPhoneNumber?.call(event.phoneNumber);
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
      try {
        await signOut!();
        emit(AuthUnAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

//=====================SignOut-Event========================
    on<CheckStatusEvent>((event, emit) async {
      final user = getCurrentUser!();
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    });
  }
}
