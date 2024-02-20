import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template authentication_repository}
/// __Authentication Repository__ is a contract for authentication related repository operations.
/// {@endtemplate}
abstract class AuthenticationRepository {
  ///{@macro authentication_repository}
  const AuthenticationRepository();

  /// Signs in a user using the provided username and password.
  ///
  /// Parameters:
  /// - [String]: username
  /// - [String]: password
  ///
  /// Returns:
  /// - [TokenBundle]: containing authentication tokens.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, TokenBundle>> signIn({
    required String username,
    required String password,
  });

  /// Saves the provided [TokenBundle] to the device's secure storage.
  ///
  /// Parameters:
  /// - [TokenBundle]: containing authentication tokens.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, None>> saveTokenBundle({
    required TokenBundle tokenBundle,
  });

  /// Retrieves the refresh token from the device's secure storage.
  ///
  /// Returns:
  /// - [AuthenticationToken]: refreshToken
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, AuthenticationToken>> getRefreshToken();

  /// Deletes the authentication tokens from the device's secure storage.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, None>> deleteTokens();

  /// Refreshes the authentication tokens using the provided [refreshToken].
  ///
  /// Parameters:
  /// - [String]: refreshToken
  ///
  /// Returns:
  /// - [TokenBundle]: containing authentication tokens.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, TokenBundle>> refreshTokenBundle({
    required AuthenticationToken refreshToken,
  });

  /// Checks if the device's secure storage contains a [TokenBundle].
  ///
  /// Returns:
  /// - [bool]: true if a [TokenBundle] is present, otherwise false.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, bool>> isTokenBundlePresent();
}
