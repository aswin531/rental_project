import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/usecases/signin_email_password.dart';
import 'package:rentit/features/authentication/domain/usecases/signup_email_password.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/utils/validation/validator.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInWithEmailAndPasswordUseCase signInUseCase;
  final SignUpWithEmailAndPasswordUseCase signUpUseCase;
  final SignOut signOut;

  AuthenticationBloc(
    this.signOut, {
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthenticationInitial());

  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is SignInWithEmailAndPassword) {
      yield AuthenticationLoading();

      final emailError = CustomValidator.validateEmail(event.email);
      final passwordError = CustomValidator.validatePassword(event.password);

      if (emailError != null) {
        yield AuthenticationUnAuthenticated(emailError);
        return;
      }

      if (passwordError != null) {
        yield AuthenticationUnAuthenticated(passwordError);
        return;
      }

      try {
        final user = await signInUseCase.call(event.email, event.password);
        yield AuthenticationAuthenticated(user);
      } catch (e) {
        yield AuthenticationUnAuthenticated(e.toString());
      }
    } else if (event is SignUpWithEmailAndPassword) {
      yield AuthenticationLoading();
      final emailError = CustomValidator.validateEmail(event.email);
      final passwordError = CustomValidator.validatePassword(event.password);
      final confirmPasswordError =
          CustomValidator.validatePassword(event.confirmPassword);

      if (emailError != null) {
        yield AuthenticationUnAuthenticated(emailError);
        return;
      }

      if (passwordError != null) {
        yield AuthenticationUnAuthenticated(passwordError);
        return;
      }

      if (confirmPasswordError != null) {
        yield AuthenticationUnAuthenticated(confirmPasswordError);
        return;
      }

      if (event.password != event.confirmPassword) {
        yield const AuthenticationUnAuthenticated('Passwords do not match.');
        return;
      }

      try {
        final user = await signUpUseCase.signUpWithEmailAndPassword(
            event.name!,
            event.lastName!,
            event.email,
            event.password,
            event.confirmPassword!);
        yield AuthenticationAuthenticated(user);
      } catch (e) {
        yield AuthenticationUnAuthenticated(e.toString());
      }
    } else if (event is SignOut) {
      yield AuthenticationLoading();
      try {} catch (e) {
        yield AuthenticationUnAuthenticated(e.toString());
      }
    }
  }
}
