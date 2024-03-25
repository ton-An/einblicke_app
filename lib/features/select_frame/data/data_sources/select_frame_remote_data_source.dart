import 'dart:io';

import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_frame_remote_data_source}
/// __Select Frame Remote Data Source__ is a contract for remote data source operations helping select a frame to send an image to.
/// {@endtemplate}
abstract class SelectFrameRemoteDataSource {
  /// Gets a list of paired frames
  ///
  /// Returns:
  /// - [List<PairedFrameInfo>]: a list of [PairedFrameInfo] objects.
  ///
  /// Failures:
  /// - [DatabaseReadFailure]
  /// - [UnauthorizedFailure]
  /// - {@macro converted_dio_exceptions}
  Future<List<PairedFrameInfo>> getPairedFramesInfo();

  /// Gets the most recent image of a frame
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
  Future<File> getMostRecentImageOfFrame({
    required String frameId,
  });
}
