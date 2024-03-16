import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/select_image/data/data_sources/select_image_remote_data_source.dart';
import 'package:einblicke_app/features/select_image/domain/repositories/select_image_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_image_repository_impl}
/// __Select Image Repository Implementation__ is the concrete implementation of
/// the [SelectImageRepository] contract and handles the repository operations
/// related to selecting an image to be sent to a frame.
/// {@endtemplate}
class SelectImageRepositoryImpl implements SelectImageRepository {
  ///{@macro select_image_repository_impl}
  const SelectImageRepositoryImpl({
    required this.selectImageRemoteDataSource,
    required this.failureHandler,
  });

  final SelectImageRemoteDataSource selectImageRemoteDataSource;
  final RepositoryFailureHandler failureHandler;

  @override
  Future<Either<Failure, None>> sendImage({
    required String imagePath,
    required String frameId,
    required AuthenticationToken accessToken,
  }) async {
    try {
      await selectImageRemoteDataSource.sendImage(
        imagePath: imagePath,
        frameId: frameId,
        accessToken: accessToken,
      );

      return const Right(None());
    } catch (exception) {
      if (exception is DatabaseReadFailure ||
          exception is DatabaseWriteFailure ||
          exception is NotPairedFailure ||
          exception is StorageWriteFailure ||
          exception is UnauthorizedFailure) {
        return Left(exception as Failure);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      } else {
        rethrow;
      }
    }
  }
}
