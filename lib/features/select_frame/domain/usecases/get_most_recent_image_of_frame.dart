import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/repositories/select_frame_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/* To-Do:
    - [ ] Introduce image caching
*/

/// {@template get_most_recent_image_of_frame}
/// __Get Most Recent Image Of Frame__ gets the most recent image of a frame
///
/// Parameters:
/// - [String]: frameId
///
/// Returns:
/// - [File]: the most recent image of the frame
///
/// Failures:
/// - [DatabaseReadFailure]
/// - [StorageReadFailure]
/// - [UnauthorizedFailure]
/// - [NotPairedFailure]
/// - [NoImagesFoundFailure]
/// - {@macro converted_dio_exceptions}
/// {@endtemplate}
class GetMostRecentImageOfFrame {
  final SelectFrameRepository selectFrameRepository;

  /// {@macro get_most_recent_image_of_frame}
  const GetMostRecentImageOfFrame({
    required this.selectFrameRepository,
  });

  /// {@macro get_most_recent_image_of_frame}
  Future<Either<Failure, File>> call({
    required String frameId,
  }) async {
    return await selectFrameRepository.getMostRecentImageOfFrame(
      frameId: frameId,
    );
  }
}
