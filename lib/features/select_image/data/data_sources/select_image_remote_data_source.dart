import 'package:dio/dio.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_image_remote_data_source}
/// __Select Image Remote Data Source__ is a contract for remote data source operations
/// helping select an image destined to be sent to a frame.
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
