import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/data_sources/server_remote_handler.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

// -- Shared
class MockFailureMapper extends Mock implements FailureMapper {}

// -- Core
class MockFailureHandler extends Mock implements RepositoryFailureHandler {}

class MockServerRemoteHandler extends Mock implements ServerRemoteHandler {}

// -- Authentication
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAuthenticationLocalDataSource extends Mock
    implements AuthenticationLocalDataSource {}

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

// -- Third Party
class MockDio extends Mock implements Dio {}
