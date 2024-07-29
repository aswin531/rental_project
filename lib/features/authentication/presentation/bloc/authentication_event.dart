// part of 'authentication_bloc.dart';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInGoogleEvent extends AuthEvent {}

class SignInEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEmailPasswordEvent({required this.email, required this.password});

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

class SendPhoneCodeEvent extends AuthEvent {
  final String phoneNumber;

  const SendPhoneCodeEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class CodeSentEvent extends AuthEvent {
  final String verificationId;

  const CodeSentEvent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class VerifyPhoneCodeEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const VerifyPhoneCodeEvent({required this.verificationId, required this.smsCode});

  @override
  List<Object> get props => [verificationId, smsCode];
}

class SignOutEvent extends AuthEvent {}

class CheckStatusEvent extends AuthEvent {}

class FetchCurrentUser extends AuthEvent {}
