import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/is_signed_in.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template authentication_status_cubit}
/// __Authentication Status Cubit__ is a [Cubit] that manages the authentication
/// status of the user.
/// {@endtemplate}
class AuthenticationStatusCubit extends Cubit<AuthenticationState> {
  /// {@macro authentication_status_cubit}
  AuthenticationStatusCubit({required this.isSignedIn})
      : super(const AuthenticationInitial());

  final IsSingnedIn isSignedIn;

  void ceckAuthenticationStatus() async {
    final Either<Failure, bool> isSignedInResult = await isSignedIn();

    isSignedInResult.fold(
      (Failure failure) {
        emit(AuthenticationFailureState(failure: failure));
      },
      (bool isSignedIn) {
        if (isSignedIn) {
          emit(const AuthenticationSignedIn());
        } else {
          emit(const AuthenticationSignedOut());
        }
      },
    );
  }

  void userSignedIn() => emit(const AuthenticationSignedIn());

  void userSignedOut() => emit(const AuthenticationSignedOut());
}
