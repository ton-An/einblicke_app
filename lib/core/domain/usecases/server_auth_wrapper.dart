import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/refresh_token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

class ServerAuthWrapper<T> {
  ServerAuthWrapper({
    required this.refreshTokenBundle,
    required this.authenticationRepository,
  });

  final RefreshTokenBundle refreshTokenBundle;
  final AuthenticationRepository authenticationRepository;

  Future<Either<Failure, T>> call({
    required Future<Either<Failure, T>> Function(
      AuthenticationToken accessToken,
    ) serverCall,
  }) {
    return _getAccessToken(
      serverCall: serverCall,
    );
  }

  Future<Either<Failure, T>> _getAccessToken({
    required Future<Either<Failure, T>> Function(
      AuthenticationToken accessToken,
    ) serverCall,
    bool hasRetried = false,
  }) async {
    final Either<Failure, TokenBundle> tokenBundle =
        await authenticationRepository.getTokenBundleFromStorage();

    return tokenBundle.fold(
      (Failure failure) {
        return Left(failure);
      },
      (TokenBundle tokenBundle) {
        final AuthenticationToken accessToken = tokenBundle.accessToken;

        return _callServer(
          serverCall: serverCall,
          accessToken: accessToken,
          hasRetried: hasRetried,
        );
      },
    );
  }

  Future<Either<Failure, T>> _callServer({
    required Future<Either<Failure, T>> Function(
      AuthenticationToken accessToken,
    ) serverCall,
    required AuthenticationToken accessToken,
    required bool hasRetried,
  }) async {
    final Either<Failure, T> serverCallEither = await serverCall(accessToken);

    return serverCallEither.fold(
      (Failure failure) {
        if (failure is UnauthorizedFailure && !hasRetried) {
          return _retryWithNewTokens(serverCall: serverCall);
        }

        return Left(failure);
      },
      Right.new,
    );
  }

  Future<Either<Failure, T>> _retryWithNewTokens({
    required Future<Either<Failure, T>> Function(
      AuthenticationToken accessToken,
    ) serverCall,
  }) async {
    final Either<Failure, None> refreshTokenEither = await refreshTokenBundle();

    return refreshTokenEither.fold(
      (Failure failure) {
        return Left(failure);
      },
      (None none) {
        return _getAccessToken(serverCall: serverCall, hasRetried: true);
      },
    );
  }
}
