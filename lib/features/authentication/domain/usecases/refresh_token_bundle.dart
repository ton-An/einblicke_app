import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template refresh_token_bundle}
/// Refreshes the user's authentication tokens.
///
/// Failures:
/// - TBD
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
    final Either<Failure, AuthenticationToken> refreshTokenEither =
        await authenticationRepository.getRefreshToken();

    return refreshTokenEither.fold(
      Left.new,
      (AuthenticationToken refreshToken) => _refreshTokenBundle(refreshToken),
    );
  }

  Future<Either<Failure, None>> _refreshTokenBundle(
      AuthenticationToken refreshToken) async {
    final Either<Failure, TokenBundle> refreshTokenBundleEither =
        await authenticationRepository.refreshTokenBundle(
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
