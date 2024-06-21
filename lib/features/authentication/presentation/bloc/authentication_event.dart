import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;
  final String? confirmPassword;
  final String? name;
  final String? lastName;

  const SignUpWithEmailAndPassword(this.email, this.password,
      this.confirmPassword, this.name, this.lastName);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthenticationEvent {}
