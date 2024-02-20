import 'package:dispatch_pi_app/features/authentication/data/repository_implementation/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';

void main() {
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;
  late MockAuthenticationLocalDataSource mockLocalDataSource;
  late MockAuthenticationRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockAuthenticationLocalDataSource();
    mockRemoteDataSource = MockAuthenticationRemoteDataSource();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
      authenticationLocalDataSource: mockLocalDataSource,
      authenticationRemoteDataSource: mockRemoteDataSource,
    );
  });

  group("deleteTokens()", () {});

  group("getRefreshToken()", () {});

  group("isTokenBundlePresent()", () {});

  group("refreshTokenBundle()", () {});

  group("saveTokens()", () {});

  group("signIn()", () {});
}
