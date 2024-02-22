import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:flutter/services.dart';

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
  /// - [PlatformException]
  Future<void> saveTokenBundle({required TokenBundle tokenBundle});

  /// Checks if the authentication tokens are present in the device's secure storage.
  ///
  /// Returns:
  /// - [bool]: true if the tokens are present, false otherwise
  ///
  /// Throws:
  /// - [PlatformException]
  Future<bool> isTokenBundlePresent();

  /// Retrieves the refresh token from the device's secure storage.
  ///
  /// Returns:
  /// - [AuthenticationToken]: refreshToken
  ///
  /// Throws:
  /// - [PlatformException]
  Future<TokenBundle?> getTokenBundle();

  /// Deletes the authentication tokens from the device's secure storage.
  ///
  /// Throws:
  /// - [PlatformException]
  Future<void> deleteTokens();
}
