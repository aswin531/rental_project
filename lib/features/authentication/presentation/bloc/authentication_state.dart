import 'package:equatable/equatable.dart';

abstract class Authstate extends Equatable {
  const Authstate();

  @override
  List<Object> get props => [];
}

//=========================================
class AuthInitial extends Authstate {}

//=========================================

class AuthAuthenticated extends Authstate {
  // AuthAuthenticated(user);

  // @override
  // List<Object?> get props => [user];
  //   String get userEmail => user.email; // Assuming email is a property in User

  //final User? user;
  //  const AuthAuthenticated(this.user);
}

//=========================================

class CodeSentState extends Authstate {}

//=========================================

class AuthUnAuthenticated extends Authstate {}

//=========================================

class AuthError extends Authstate {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

//=========================================

