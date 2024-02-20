import 'package:dartz/dartz.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/authentication_token.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/token_bundle.dart';

/// {@template authentication_local_data_source}
/// __Authentication Local Data Source__ is the contract for the authentication related
/// local data source operations.
/// {@endtemplate}
abstract class AuthenticationLocalDataSource {
  ///{@macro authentication_local_data_source}
  const AuthenticationLocalDataSource();

  /// Saves the provided [TokenBundle] to the device's secure storage.
  ///
  /// Parameters:
  /// - [TokenBundle]: containing authentication tokens
  ///
  /// Throws:
  /// - TBD
  Future<TokenBundle> saveTokenBundle({required TokenBundle tokenBundle});

  /// Retrieves the refresh token from the device's secure storage.
  ///
  /// Returns:
  /// - [AuthenticationToken]: refreshToken
  ///
  /// Throws:
  /// - TBD
  Future<AuthenticationToken> getRefreshToken();

  /// Deletes the authentication tokens from the device's secure storage.
  ///
  /// Throws:
  /// - TBD
  Future<None> deleteTokens();
}
