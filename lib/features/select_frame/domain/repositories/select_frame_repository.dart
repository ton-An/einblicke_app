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
  /// - {@macro converted_dio_exceptions}
  Future<Either<Failure, List<PairedFrameInfo>>> getPairedFramesInfo();
}
