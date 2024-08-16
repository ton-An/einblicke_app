import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:file/file.dart';
import 'package:http_parser/http_parser.dart';

/// {@template select_image_remote_data_source}
/// __Select Image Remote Data Source__ is a contract for remote data source operations
/// responsible for selecting an image destined to be sent to a frame.
/// {@endtemplate}
abstract class SelectImageRemoteDataSource {
  /// {@macro select_image_remote_data_source}
  const SelectImageRemoteDataSource();

  /// Sends an image to the server to be distributed to a frame
  ///
  /// Parameters:
  /// - [String]: imagePath
  /// - [String]: frameId
  /// - [AuthenticationToken]: accessToken
  ///
  /// Throws:
  /// - [DatabaseReadFailure]
  /// - [DatabaseWriteFailure]
  /// - [NotPairedFailure]
  /// - [StorageWriteFailure]
  /// - [UnauthorizedFailure]
  /// - [DioException]
  Future<void> sendImage({
    required String imagePath,
    required String frameId,
    required AuthenticationToken accessToken,
  });
}

/// {@template select_image_remote_data_source_impl}
/// __Select Image Remote Data Source Impl__ is a concrete implementation of [SelectImageRemoteDataSource]
/// and is responsible for selecting an image destined to be sent to a frame.
/// {@endtemplate}
class SelectImageRemoteDataSourceImpl extends SelectImageRemoteDataSource {
  /// {@macro select_image_remote_data_source_impl}
  const SelectImageRemoteDataSourceImpl({
    required this.serverRemoteHandler,
    required this.fileSystem,
  });

  final ServerRemoteHandler serverRemoteHandler;
  final FileSystem fileSystem;

  @override
  Future<void> sendImage({
    required String imagePath,
    required String frameId,
    required AuthenticationToken accessToken,
  }) async {
    final Uint8List imageBytes = await fileSystem.file(imagePath).readAsBytes();

    final MultipartFile image = MultipartFile.fromBytes(
      imageBytes,
      filename: imagePath.split("/").last,
      contentType: MediaType("image", "jpg"),
    );

    final FormData formData = FormData.fromMap({
      "photo": image,
      "frame_id": frameId,
    });

    await serverRemoteHandler.multipartPost(
      path: "/upload_image",
      formData: formData,
      accessToken: accessToken.token,
    );
  }
}
