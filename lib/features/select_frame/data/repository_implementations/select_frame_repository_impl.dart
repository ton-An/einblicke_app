import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/features/select_frame/data/data_sources/select_frame_remote_data_source.dart';
import 'package:einblicke_app/features/select_frame/domain/repositories/select_frame_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template select_frame_repository}
/// __Select Frame Repository Implementation__ is the concrete implementation of
/// the [SelectFrameRepository] contract and handles the repository operations
/// related to selecting a frame to send an image to.
/// {@endtemplate}
class SelectFrameRepositoryImpl extends SelectFrameRepository {
  /// {@macro select_frame_repository}
  const SelectFrameRepositoryImpl({
    required this.selectFrameRemoteDataSource,
    required this.failureHandler,
  });

  final SelectFrameRemoteDataSource selectFrameRemoteDataSource;
  final RepositoryFailureHandler failureHandler;

  @override
  Future<Either<Failure, File>> getMostRecentImageOfFrame(
      {required String frameId}) async {
    try {
      final File image = await selectFrameRemoteDataSource
          .getMostRecentImageOfFrame(frameId: frameId);

      return Right(image);
    } catch (exception) {
      if (exception is DatabaseReadFailure ||
          exception is StorageReadFailure ||
          exception is UnauthorizedFailure ||
          exception is NotPairedFailure ||
          exception is NoImagesFoundFailure) {
        return Left(exception as Failure);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      }

      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<PairedFrameInfo>>> getPairedFramesInfo() async {
    try {
      final List<PairedFrameInfo> pairedFrameInfos =
          await selectFrameRemoteDataSource.getPairedFramesInfo();

      return Right(pairedFrameInfos);
    } catch (exception) {
      if (exception is DatabaseReadFailure ||
          exception is UnauthorizedFailure) {
        return Left(exception as Failure);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      }

      rethrow;
    }
  }
}
