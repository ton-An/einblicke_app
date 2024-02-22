import 'dart:convert';

import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  static const _tokenBundleKey = "token_bundle";

  const AuthenticationLocalDataSourceImpl({
    required this.secureStorage,
  });

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> deleteTokens() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<TokenBundle?> getTokenBundle() async {
    final String? tokenBundleJsonString =
        await secureStorage.read(key: _tokenBundleKey);

    if (tokenBundleJsonString == null) return null;

    final TokenBundle tokenBundle = TokenBundle.fromJson(
      jsonDecode(tokenBundleJsonString) as Map<String, dynamic>,
    );

    return tokenBundle;
  }

  @override
  Future<bool> isTokenBundlePresent() async {
    final isTokenBundlePresent =
        await secureStorage.containsKey(key: _tokenBundleKey);

    return isTokenBundlePresent;
  }

  @override
  Future<void> saveTokenBundle({required TokenBundle tokenBundle}) async {
    final String tokenBundleJsonString = jsonEncode(tokenBundle.toJson());

    await secureStorage.write(
      key: _tokenBundleKey,
      value: tokenBundleJsonString,
    );
  }
}
