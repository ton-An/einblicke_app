import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/services.dart';

/// {@template authentication_repository_impl}
/// __Authentication Repository Implementation__ is the concrete implementation of
/// the [AuthenticationRepository] contract and handles the authentication related
/// repository operations.
/// {@endtemplate}
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  ///{@macro authentication_repository_impl}
  const AuthenticationRepositoryImpl({
    required this.authenticationLocalDataSource,
    required this.authenticationRemoteDataSource,
    required this.failureHandler,
  });

  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final RepositoryFailureHandler failureHandler;

  @override
  Future<Either<Failure, None>> deleteTokens() async {
    try {
      await authenticationLocalDataSource.deleteTokens();

      return const Right(None());
    } on PlatformException {
      return const Left(SecureStorageWriteFailure());
    }
  }

  @override
  Future<Either<Failure, TokenBundle>> getTokenBundleFromStorage() async {
    try {
      final TokenBundle? tokenBundle =
          await authenticationLocalDataSource.getTokenBundle();

      if (tokenBundle == null) {
        return const Left(SecureStorageReadFailure());
      }

      return Right(tokenBundle);
    } on PlatformException {
      return const Left(SecureStorageReadFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isTokenBundlePresent() async {
    try {
      final bool isTokenBundlePresent =
          await authenticationLocalDataSource.isTokenBundlePresent();

      return Right(isTokenBundlePresent);
    } on PlatformException {
      return const Left(SecureStorageReadFailure());
    }
  }

  @override
  Future<Either<Failure, None>> saveTokenBundle(
      {required TokenBundle tokenBundle}) async {
    try {
      await authenticationLocalDataSource.saveTokenBundle(
          tokenBundle: tokenBundle);

      return const Right(None());
    } on PlatformException {
      return const Left(SecureStorageWriteFailure());
    }
  }

  @override
  Future<Either<Failure, TokenBundle>> getNewTokenBundle(
      {required AuthenticationToken refreshToken}) async {
    try {
      final TokenBundle tokenBundle = await authenticationRemoteDataSource
          .getNewTokenBundle(refreshToken: refreshToken);

      return Right(tokenBundle);
    } catch (exception) {
      if (exception is UnauthorizedFailure) {
        return Left(exception);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      }

      rethrow;
    }
  }

  @override
  Future<Either<Failure, TokenBundle>> signIn({
    required String username,
    required String password,
    required Secrets secrets,
  }) async {
    try {
      final TokenBundle tokenBundle = await authenticationRemoteDataSource
          .signIn(username: username, password: password, secrets: secrets);

      return Right(tokenBundle);
    } catch (exception) {
      if (exception is UnauthorizedFailure ||
          exception is UserNotFoundFailure ||
          exception is DatabaseReadFailure) {
        return Left(exception as Failure);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      }

      rethrow;
    }
  }
}
