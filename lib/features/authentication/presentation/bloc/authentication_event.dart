// part of 'authentication_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInGoogleEvent extends AuthEvent {}


class SigInEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SigInEmailPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class SignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  const SignUpEmailPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class SignInPhoneEvent extends AuthEvent {
  final String phoneNumber;
  final String smsCode;
  const SignInPhoneEvent({required this.phoneNumber, required this.smsCode});

  @override
  List<Object> get props => [phoneNumber, smsCode];
}


class SignOutEvent extends AuthEvent{}


class CheckStatusEvent extends AuthEvent{}