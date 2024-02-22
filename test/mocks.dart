import 'package:einblicke_app/core/data/repository_impl/failure_handler.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';

// -- Core
class MockFailureHandler extends Mock implements FailureHandler {}

// -- Authentication
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAuthenticationLocalDataSource extends Mock
    implements AuthenticationLocalDataSource {}

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}
