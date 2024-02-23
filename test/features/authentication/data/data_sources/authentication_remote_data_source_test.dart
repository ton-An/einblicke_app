import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late AuthenticationRemoteDataSourceImpl authenticationRemoteDataSourceImpl;
  late MockServerRemoteHandler mockServerRemoteHandler;

  setUp(() {
    mockServerRemoteHandler = MockServerRemoteHandler();
    authenticationRemoteDataSourceImpl = AuthenticationRemoteDataSourceImpl(
      serverRemoteHandler: mockServerRemoteHandler,
    );
  });

  group("getNewTokenBundle()", () {
    setUp(() {
      when(() => mockServerRemoteHandler.post(any(), any()))
          .thenAnswer((_) async => tTokenBundleMap);
    });

    test("should call the server to get a new [TokenBundle] and return it",
        () async {
      // act
      final result = await authenticationRemoteDataSourceImpl.getNewTokenBundle(
          refreshToken: tRefreshToken);

      // assert
      expect(result, tTokenBundle);
      verify(
        () => mockServerRemoteHandler.post(
          "/refresh_tokens",
          {"refresh_token": tRefreshTokenString},
        ),
      );
    });
  });

  group("signIn()", () {
    test(
        "should call the server to sign in the user and return a [TokenBundle]",
        () async {
      // arrange
      when(() => mockServerRemoteHandler.post(any(), any()))
          .thenAnswer((_) async => tTokenBundleMap);

      // act
      final result = await authenticationRemoteDataSourceImpl.signIn(
        username: tUsername,
        password: tPassword,
      );

      // assert
      expect(result, tTokenBundle);
      verify(
        () => mockServerRemoteHandler.post(
          "/sign_in",
          {"username": tUsername, "password": tPassword},
        ),
      );
    });
  });
}
