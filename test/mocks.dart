import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/data_sources/server_remote_handler.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/core/domain/usecases/server_auth_wrapper.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/refresh_token_bundle.dart';
import 'package:einblicke_app/features/select_frame/data/data_sources/select_frame_remote_data_source.dart';
import 'package:einblicke_app/features/select_frame/domain/repositories/select_frame_repository.dart';
import 'package:einblicke_app/features/select_image/data/data_sources/select_image_remote_data_source.dart';
import 'package:einblicke_app/features/select_image/domain/repositories/select_image_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:file/file.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

// -- Shared
class MockFailureMapper extends Mock implements FailureMapper {}

// -- Core
class MockFailureHandler extends Mock implements RepositoryFailureHandler {}

class MockServerRemoteHandler extends Mock implements ServerRemoteHandler {}

class MockServerCall extends Mock {
  Future<Either<Failure, dynamic>> call(AuthenticationToken accessToken);
}

class MockServerAuthWrapper<T> extends Mock implements ServerAuthWrapper<T> {}

// -- Authentication
class MockRefreshTokenBundle extends Mock implements RefreshTokenBundle {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAuthenticationLocalDataSource extends Mock
    implements AuthenticationLocalDataSource {}

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

// -- Select Image
class MockSelectImageRepository extends Mock implements SelectImageRepository {}

class MockSelectImageRemoteDataSource extends Mock
    implements SelectImageRemoteDataSource {}

// -- Select Frame
class MockSelectFrameRepository extends Mock implements SelectFrameRepository {}

class MockSelectFrameRemoteDataSource extends Mock
    implements SelectFrameRemoteDataSource {}

// -- Third Party
class MockDio extends Mock implements Dio {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockFileSystem extends Mock implements FileSystem {}

class MockFile extends Mock implements File {}
