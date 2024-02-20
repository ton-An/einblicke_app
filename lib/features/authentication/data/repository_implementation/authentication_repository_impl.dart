import 'package:dartz/dartz.dart';
import 'package:dispatch_pi_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:dispatch_pi_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/authentication_token.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/token_bundle.dart';
import 'package:dispatch_pi_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dispatch_pi_shared/src/core/failures/failure.dart';

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
  });

  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  @override
  Future<Either<Failure, None>> deleteTokens() {
    // TODO: implement deleteTokens
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthenticationToken>> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> isTokenBundlePresent() {
    // TODO: implement isTokenBundlePresent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TokenBundle>> refreshTokenBundle(
      {required AuthenticationToken refreshToken}) {
    // TODO: implement refreshTokenBundle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, None>> saveTokenBundle(
      {required TokenBundle tokenBundle}) {
    // TODO: implement saveTokens
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TokenBundle>> signIn(
      {required String username, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
