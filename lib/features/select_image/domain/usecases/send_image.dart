import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/refresh_token_bundle.dart';
import 'package:einblicke_app/features/select_image/domain/repositories/select_image_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template send_image}
/// __Send Image__ sends an image to the server to be distributed to a frame
///
/// Parameters:
/// - [String]: imagePath
/// - [String]: frameId
///
/// Failures:
/// - TBD
/// {@endtemplate}
class SendImage {
  /// {@macro send_image}
  SendImage({
    required this.selectImageRepository,
    required this.refreshTokenBundle,
    required this.authenticationRepository,
  });

  final SelectImageRepository selectImageRepository;
  final RefreshTokenBundle refreshTokenBundle;
  final AuthenticationRepository authenticationRepository;

  /// {@macro send_image}
  Future<Either<Failure, None>> call(
      {required String imagePath, required String frameId}) {
    return _getAccessToken(imagePath: imagePath, frameId: frameId);
  }

  Future<Either<Failure, None>> _getAccessToken({
    required String imagePath,
    required String frameId,
  }) async {
    final Either<Failure, TokenBundle> tokenBundle =
        await authenticationRepository.getTokenBundleFromStorage();

    return tokenBundle.fold(
      (Failure failure) {
        return Left(failure);
      },
      (TokenBundle tokenBundle) {
        final AuthenticationToken accessToken = tokenBundle.accessToken;

        return _sendImage(
            imagePath: imagePath, frameId: frameId, accessToken: accessToken);
      },
    );
  }

  Future<Either<Failure, None>> _sendImage({
    required String imagePath,
    required String frameId,
    required AuthenticationToken accessToken,
  }) async {
    final Either<Failure, None> sendImageEither =
        await selectImageRepository.sendImage(
      imagePath: imagePath,
      frameId: frameId,
      accessToken: accessToken,
    );

    return sendImageEither.fold(
      (Failure failure) {
        if (failure is UnauthorizedFailure) {
          return _refreshTokenBundle();
        }

        return Left(failure);
      },
      Right.new,
    );
  }

  Future<Either<Failure, None>> _refreshTokenBundle() async {
    return refreshTokenBundle();
  }
}
