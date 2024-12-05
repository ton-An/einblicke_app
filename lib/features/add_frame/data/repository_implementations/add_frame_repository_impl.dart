import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/features/add_frame/data/datasources/add_frame_remote_data_source.dart';
import 'package:einblicke_app/features/add_frame/domain/repositories/add_frame_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';

// ToDo: - add actual failures to addFrame

class AddFrameRepositoryImpl extends AddFrameRepository {
  const AddFrameRepositoryImpl({
    required this.addFrameRemoteDataSource,
    required this.failureHandler,
  });

  final AddFrameRemoteDataSource addFrameRemoteDataSource;
  final RepositoryFailureHandler failureHandler;

  @override
  Future<Either<Failure, None>> addFrame({
    required String qrCode,
    required String frameName,
    required AuthenticationToken accessToken,
  }) async {
    try {
      await addFrameRemoteDataSource.addFrame(
        qrCode: qrCode,
        frameName: frameName,
        accessToken: accessToken,
      );

      return const Right(None());
    } catch (exception) {
      if (exception is DatabaseReadFailure ||
          exception is StorageReadFailure ||
          exception is UnauthorizedFailure) {
        return Left(exception as Failure);
      } else if (exception is DioException) {
        return Left(failureHandler.dioExceptionMapper(exception));
      }

      rethrow;
    }
  }
}
