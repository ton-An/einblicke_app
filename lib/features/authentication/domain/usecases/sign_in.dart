import 'package:dartz/dartz.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

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
  SignIn({required this.authenticationRepository, required this.secrets});

  final AuthenticationRepository authenticationRepository;
  final Secrets secrets;

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
      secrets: secrets,
    );

    return signInEither.fold(
      Left.new,
      (tokenBundle) => _saveTokens(tokenBundle),
    );
  }

  Future<Either<Failure, None>> _saveTokens(TokenBundle tokenBundle) async {
    return await authenticationRepository.saveTokenBundle(
        tokenBundle: tokenBundle);
  }
}
