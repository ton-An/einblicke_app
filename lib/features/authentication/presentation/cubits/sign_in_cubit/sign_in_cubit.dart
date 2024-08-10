import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.signInUsecase,
  }) : super(const SignInInitial());

  final SignIn signInUsecase;

  String username = "";
  String password = "";

  void signIn() async {
    emit(const SignInLoading());

    final Either<Failure, None> signInEither =
        await signInUsecase(username: username, password: password);

    signInEither.fold(
      (Failure failure) {
        emit(SignInFailure(failure: failure));
      },
      (None none) {
        emit(const SignInSuccess());
      },
    );
  }

  void updateUsername(String username) {
    this.username = username;
  }

  void updatePassword(String password) {
    this.password = password;
  }
}
