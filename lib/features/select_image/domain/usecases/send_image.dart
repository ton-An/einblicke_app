import 'package:dartz/dartz.dart';
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
  final SelectImageRepository selectImageRepository;
  final RefreshTokenBundle refreshTokenBundle;

  /// {@macro send_image}
  SendImage({
    required this.selectImageRepository,
    required this.refreshTokenBundle,
  });

  /// {@macro send_image}
  Future<Either<Failure, None>> call(
      {required String imagePath, required String frameId}) {
    return _sendImage(imagePath: imagePath, frameId: frameId);
  }

  Future<Either<Failure, None>> _sendImage({
    required String imagePath,
    required String frameId,
  }) async {
    final Either<Failure, None> sendImageEither =
        await selectImageRepository.sendImage(
      imagePath: imagePath,
      frameId: frameId,
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
