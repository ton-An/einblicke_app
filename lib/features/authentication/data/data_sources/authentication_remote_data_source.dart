import 'package:dio/dio.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template authentication_remote_data_source}
/// __Authentication Remote Data Source__ is the contract for the authentication related
/// remote data source operations.
/// {@endtemplate}
abstract class AuthenticationRemoteDataSource {
  ///{@macro authentication_remote_data_source}
  const AuthenticationRemoteDataSource();

  /// Signs in the user with the provided [username] and [password].
  ///
  /// Returns:
  /// - [TokenBundle]: containing authentication tokens
  ///
  /// Throws:
  /// - [UnauthorizedFailure]
  /// - [UserNotFoundFailure]
  /// - [DatabaseReadFailure]
  /// - [DioException]
  Future<TokenBundle> signIn(
      {required String username, required String password});

  /// Refreshes the authentication tokens using the provided [refreshToken].
  ///
  /// Returns:
  /// - [TokenBundle]: containing authentication tokens
  ///
  /// Throws:
  /// - [UnauthorizedFailure]
  /// - [DioException]
  Future<TokenBundle> getNewTokenBundle(
      {required AuthenticationToken refreshToken});
}