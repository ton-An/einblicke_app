import 'package:dartz/dartz.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/token_bundle.dart';
import 'package:dispatch_pi_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dispatch_pi_shared/dispatch_pi_shared.dart';

/// {@template sign_in}
/// Signs  the user in using the provided username and password.
///
/// Parameters:
/// - [String]: username
/// - [String]: password
///
/// Failures:
/// - TBD
/// {@endtemplate}
class SignIn {
  /// {@macro sign_in}
  SignIn({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  /// {@macro sign_in}
  Future<Either<Failure, None>> call({
    required String username,
    required String password,
  }) async {
    return _signIn(username: username, password: password);
  }

  Future<Either<Failure, None>> _signIn({
    required String username,
    required String password,
  }) async {
    final Either<Failure, TokenBundle> signInEither =
        await authenticationRepository.signIn(
      username: username,
      password: password,
    );

    return signInEither.fold(
      (failure) => Left(failure),
      (tokenBundle) => _saveTokens(tokenBundle),
    );
  }

  Future<Either<Failure, None>> _saveTokens(TokenBundle tokenBundle) async {
    return await authenticationRepository.saveTokens(tokenBundle: tokenBundle);
  }
}
