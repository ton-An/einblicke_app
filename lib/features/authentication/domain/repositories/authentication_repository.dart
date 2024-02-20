import 'package:dartz/dartz.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/token_bundle.dart';
import 'package:dispatch_pi_shared/dispatch_pi_shared.dart';

/// {@template authentication_repository}
/// __Authentication Repository__ is a contract for authentication related repository operations.
/// {@endtemplate}
abstract class AuthenticationRepository {
  ///{@macro authentication_repository}
  const AuthenticationRepository();

  /// Signs in a user using the provided email and password.
  ///
  /// Parameters:
  /// - [String]: email
  /// - [String]: password
  ///
  /// Returns:
  /// - [TokenBundle]: containing authentication tokens.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, TokenBundle>> signIn({
    required String email,
    required String password,
  });

  /// Saves the provided [TokenBundle] to the device's secure storage.
  ///
  /// Parameters:
  /// - [TokenBundle]: containing authentication tokens.
  ///
  /// Failures:
  /// - TBD
  Future<Either<Failure, None>> saveTokens({
    required TokenBundle tokenBundle,
  });

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
    required String refreshToken,
  });
}
