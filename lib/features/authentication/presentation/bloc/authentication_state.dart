import 'package:equatable/equatable.dart';

abstract class Authstate extends Equatable {
  const Authstate();

  @override
  List<Object> get props => [];
}
//=========================================
class AuthInitial extends Authstate {}

//=========================================

class AuthAuthenticated extends Authstate {}

//=========================================

class AuthUnAuthenticated extends Authstate {}

//=========================================

class AuthError extends Authstate {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}



