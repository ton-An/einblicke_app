import 'package:dartz/dartz.dart';
import 'package:einblicke_app/core/domain/usecases/server_auth_wrapper.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
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
/// - [DatabaseReadFailure]
/// - [DatabaseWriteFailure]
/// - [NotPairedFailure]
/// - [StorageWriteFailure]
/// - [UnauthorizedFailure]
/// - {@macro converted_dio_exceptions}
/// {@endtemplate}
class SendImage {
  /// {@macro send_image}
  SendImage({
    required this.selectImageRepository,
    required this.serverAuthWrapper,
  });

  final SelectImageRepository selectImageRepository;
  final ServerAuthWrapper<None> serverAuthWrapper;

  /// {@macro send_image}
  Future<Either<Failure, None>> call(
      {required String imagePath, required String frameId}) {
    return _sendImage(imagePath: imagePath, frameId: frameId);
  }

  Future<Either<Failure, None>> _sendImage({
    required String imagePath,
    required String frameId,
  }) async {
    final Either<Failure, None> sendImageEither = await serverAuthWrapper(
      serverCall: (AuthenticationToken accessToken) {
        return selectImageRepository.sendImage(
          imagePath: imagePath,
          frameId: frameId,
          accessToken: accessToken,
        );
      },
    );

    return sendImageEither;
  }
}
