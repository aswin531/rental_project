import 'package:equatable/equatable.dart';
import 'package:rentit/features/authentication/domain/entity/user_entity.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//Initialising Authentication State
class AuthenticationInitial extends AuthenticationState {}

//Loading Authentication State
class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  const AuthenticationAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}



class AuthenticationUnAuthenticated extends AuthenticationState {
  final String message;

  const AuthenticationUnAuthenticated(this.message);

  @override
  List<Object> get props => [message];
}


