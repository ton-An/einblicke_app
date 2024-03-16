import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/* To-Do:
    - [ ] Rename this class (e.g. to GetNewTokenBundle)
*/

/// {@template refresh_token_bundle}
/// Refreshes the user's authentication tokens.
///
/// Failures:
/// - [SecureStorageReadFailure]
/// - [SecureStorageWriteFailure]
/// - [UnauthorizedFailure]
/// - {@macro converted_dio_exceptions}
/// {@endtemplate}
class RefreshTokenBundle {
  /// {@macro refresh_token_bundle}
  const RefreshTokenBundle({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  /// {@macro refresh_token_bundle}
  Future<Either<Failure, None>> call() async {
    return _getRefreshToken();
  }

  Future<Either<Failure, None>> _getRefreshToken() async {
    final Either<Failure, TokenBundle> refreshTokenEither =
        await authenticationRepository.getTokenBundleFromStorage();

    return refreshTokenEither.fold(
      Left.new,
      (TokenBundle tokenBundle) {
        final AuthenticationToken refreshToken = tokenBundle.refreshToken;

        return _refreshTokenBundle(refreshToken);
      },
    );
  }

  Future<Either<Failure, None>> _refreshTokenBundle(
      AuthenticationToken refreshToken) async {
    final Either<Failure, TokenBundle> refreshTokenBundleEither =
        await authenticationRepository.getNewTokenBundle(
      refreshToken: refreshToken,
    );

    return refreshTokenBundleEither.fold(
      Left.new,
      (TokenBundle tokenBundle) => _saveTokens(tokenBundle),
    );
  }

  Future<Either<Failure, None>> _saveTokens(TokenBundle tokenBundle) async {
    return await authenticationRepository.saveTokenBundle(
        tokenBundle: tokenBundle);
  }
}
