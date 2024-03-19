import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:equatable/equatable.dart';

/* 
  To-Dos:
  - [ ] Improve naming
*/

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object> get props => [];
}

class AuthenticationSignedIn extends AuthenticationState {
  const AuthenticationSignedIn();

  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthenticationState {
  const AuthenticationSignedOut();

  @override
  List<Object> get props => [];
}

class AuthenticationFailureState extends AuthenticationState {
  final Failure failure;

  const AuthenticationFailureState({required this.failure});

  @override
  List<Object> get props => [failure];
}
