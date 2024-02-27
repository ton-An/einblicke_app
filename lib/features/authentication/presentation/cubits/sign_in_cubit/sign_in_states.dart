import 'package:einblicke_shared/einblicke_shared.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccess extends SignInState {
  const SignInSuccess();
}

class SignInFailure extends SignInState {
  const SignInFailure({
    required this.failure,
  });

  final Failure failure;
}
