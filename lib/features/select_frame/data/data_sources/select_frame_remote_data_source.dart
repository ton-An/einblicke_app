import 'dart:typed_data';

import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';

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
  Future<List<PairedFrameInfo>> getPairedFramesInfo({
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
  Future<Uint8List> getMostRecentImageOfFrame({
    required String frameId,
    required AuthenticationToken accessToken,
    // required AuthenticationToken accessToken,
  });
}

/// {@template select_frame_remote_data_source_impl}
/// __Select Frame Remote Data Source Impl__ is a concrete implementation of [SelectFrameRemoteDataSource]
/// and is responsible for selecting a frame to send an image to.
/// {@endtemplate}
class SelectFrameRemoteDataSourceImpl implements SelectFrameRemoteDataSource {
  /// {@macro select_frame_remote_data_source_impl}
  const SelectFrameRemoteDataSourceImpl({
    required this.serverRemoteHandler,
  });

  final ServerRemoteHandler serverRemoteHandler;

  @override
  Future<Uint8List> getMostRecentImageOfFrame({
    required String frameId,
    required AuthenticationToken accessToken,
  }) async {
    final Uint8List response = await serverRemoteHandler.getBytes(
      path: "/latest_image_of_frame?frame_id=$frameId",
      accessToken: accessToken.token,
    );

    return response;
  }

  @override
  Future<List<PairedFrameInfo>> getPairedFramesInfo({
    required AuthenticationToken accessToken,
  }) async {
    final Map<String, dynamic> response = await serverRemoteHandler.get(
      path: "/paired_frames",
      accessToken: accessToken.token,
    );

    final List pairedFramesInfoJsonList = response["paired_frames"] as List;

    final List<PairedFrameInfo> pairedFramesInfo = pairedFramesInfoJsonList
        .map((dynamic e) => PairedFrameInfo.fromJson(e as Map<String, dynamic>))
        .toList();

    return pairedFramesInfo;
  }
}
