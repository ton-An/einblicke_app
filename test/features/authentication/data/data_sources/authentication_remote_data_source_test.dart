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

  setUpAll(() {
    registerFallbackValue(tFakeSecrets);
  });

  group("getNewTokenBundle()", () {
    test("should call the server to get a new [TokenBundle] and return it",
        () async {
// arrange
      when(() => mockServerRemoteHandler.post(
            path: any(named: "path"),
            body: any(named: "body"),
          )).thenAnswer((_) async => tTokenBundleMap);

      // act
      final result = await authenticationRemoteDataSourceImpl.getNewTokenBundle(
          refreshToken: tRefreshToken);

      // assert
      expect(result, tTokenBundle);
      verify(
        () => mockServerRemoteHandler.post(
          path: "/refresh_tokens",
          body: {"refresh_token": tRefreshTokenString},
        ),
      );
    });
  });

  group("signIn()", () {
    test(
        "should call the server to sign in the user and return a [TokenBundle]",
        () async {
      // arrange
      when(
        () => mockServerRemoteHandler.post(
          path: any(named: "path"),
          body: any(named: "body"),
          headers: any(named: "headers"),
        ),
      ).thenAnswer((_) async => tTokenBundleMap);

      // act
      final result = await authenticationRemoteDataSourceImpl.signIn(
        username: tUsername,
        password: tPassword,
        secrets: tFakeSecrets,
      );

      // assert
      expect(result, tTokenBundle);
      verify(
        () => mockServerRemoteHandler.post(
            path: "/sign_in",
            body: tSignInRequestMap,
            headers: tSignInRequestHeaders),
      );
    });
  });
}
