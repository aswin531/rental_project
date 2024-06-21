import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/usecases/signin_email_password.dart';
import 'package:rentit/features/authentication/domain/usecases/signup_email_password.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInWithEmailAndPasswordUseCase signInUseCase;
  final SignUpWithEmailAndPasswordUseCase signUpUseCase;

  AuthenticationBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthenticationInitial());

  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is SignInWithEmailAndPassword) {
      yield AuthenticationLoading();
      try {
        final user = await signInUseCase.call(event.email, event.password);
        yield AuthenticationAuthenticated(user);
      } catch (e) {
        yield AuthenticationUnAuthenticated(e.toString());
      }
    } else if (event is SignUpWithEmailAndPassword) {
      yield AuthenticationLoading();
      try {
        final user = await signUpUseCase.call(event.email, event.password);
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
