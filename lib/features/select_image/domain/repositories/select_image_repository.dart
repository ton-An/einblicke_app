import 'package:dartz/dartz.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_image_repository}
/// __Select Image Repository__ is a contract for repository operations helping select an image destined to be sent to a frame.
/// {@endtemplate}
abstract class SelectImageRepository {
  /// {@macro select_image_repository}
  const SelectImageRepository();

  /// Sends an image to the server to be distributed to a frame
  ///
  /// Parameters:
  /// - [String]: imagePath
  /// - [String]: frameId
  /// - [AuthenticationToken]: accessToken
  ///
  /// Failures:
  /// - [DatabaseReadFailure]
  /// - [DatabaseWriteFailure]
  /// - [NotPairedFailure]
  /// - [StorageWriteFailure]
  /// - [UnauthorizedFailure]
  /// - {@macro converted_dio_exceptions}
  Future<Either<Failure, None>> sendImage({
    required String imagePath,
    required String frameId,
    required AuthenticationToken accessToken,
  });
}
