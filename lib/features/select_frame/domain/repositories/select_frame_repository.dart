import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_frame_repository}
/// __Select Frame Repository__ is a contract for repository operations helping select a frame to send an image to.
/// {@endtemplate}
abstract class SelectFrameRepository {
  /// {@macro select_frame_repository}
  const SelectFrameRepository();

  /// Gets a list of paired frames
  ///
  /// Returns:
  /// - [List<PairedFrameInfo>]: a list of [PairedFrameInfo] objects.
  ///
  /// Failures:
  /// - [DatabaseReadFailure]
  /// - [UnauthorizedFailure]
  /// - {@macro converted_dio_exceptions}
  Future<Either<Failure, List<PairedFrameInfo>>> getPairedFramesInfo({
    required AuthenticationToken accessToken,
  });

  /// Gets the most recent image of a frame
  ///
  /// Parameters:
  /// - [String]: frameId
  ///
  /// Returns:
  /// - [Uint8List]: the most recent image of the frame
  ///
  /// Failures:
  /// - [DatabaseReadFailure]
  /// - [StorageReadFailure]
  /// - [UnauthorizedFailure]
  /// - [NotPairedFailure]
  /// - [NoImagesFoundFailure]
  /// - {@macro converted_dio_exceptions}
  Future<Either<Failure, Uint8List>> getMostRecentImageOfFrame({
    required String frameId,
    required AuthenticationToken accessToken,
  });
}
