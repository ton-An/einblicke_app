import 'package:dartz/dartz.dart';
import 'package:einblicke_app/core/domain/usecases/server_auth_wrapper.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures.dart';
import '../../../mocks.dart';

void main() {
  late ServerAuthWrapper serverAuthWrapper;
  late MockRefreshTokenBundle mockRefreshTokenBundle;
  late MockAuthenticationRepository mockAuthenticationRepository;

  late MockServerCall mockServerCall;

  setUp(() {
    // -- Definitions
    mockRefreshTokenBundle = MockRefreshTokenBundle();
    mockAuthenticationRepository = MockAuthenticationRepository();
    serverAuthWrapper = ServerAuthWrapper(
      refreshTokenBundle: mockRefreshTokenBundle,
      authenticationRepository: mockAuthenticationRepository,
    );

    mockServerCall = MockServerCall();

    // -- Stubs
    when(
      () => mockAuthenticationRepository.getTokenBundleFromStorage(),
    ).thenAnswer((_) => Future.value(Right(tTokenBundle)));
    when(
      () => mockServerCall(
        any(),
      ),
    ).thenAnswer((invocation) => Future.value(const Right(None())));
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  test("should get the [TokenBundle] from the [AuthenticationRepository]",
      () async {
    // act
    await serverAuthWrapper(serverCall: mockServerCall);

    // assert
    verify(() => mockAuthenticationRepository.getTokenBundleFromStorage());
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(
      () => mockAuthenticationRepository.getTokenBundleFromStorage(),
    ).thenAnswer((_) => Future.value(const Left(SecureStorageReadFailure())));

    // act
    final result = await serverAuthWrapper(serverCall: mockServerCall);

    // assert
    expect(result, const Left(SecureStorageReadFailure()));
  });

  test("should call the callback to the server", () async {
    // act
    final result = await serverAuthWrapper(serverCall: mockServerCall);

    // assert
    expect(result, const Right(None()));
    verify(
      () => mockServerCall(tAccessToken),
    );
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(
      () => mockServerCall(
        any(),
      ),
    ).thenAnswer(
        (invocation) => Future.value(const Left(DatabaseReadFailure())));
  });

  group("if sending the [Image] returns a [UnauthorizedFailure]", () {
    setUp(() {
      // -- Stubs
      when(
        () => mockServerCall(
          any(),
        ),
      ).thenAnswer(
        (invocation) => Future.value(const Left(UnauthorizedFailure())),
      );
      when(
        () => mockRefreshTokenBundle(),
      ).thenAnswer((invocation) => Future.value(const Right(None())));
    });

    test(
        "should get a new [TokenBundle] if a [UnauthorizedFailure] was returned",
        () async {
      // act
      await serverAuthWrapper(serverCall: mockServerCall);

      // assert
      verify(() => mockRefreshTokenBundle());
    });

    test("should relay [Failure]s", () async {
      // arrange
      when(
        () => mockRefreshTokenBundle(),
      ).thenAnswer(
          (invocation) => Future.value(const Left(UnauthorizedFailure())));

      // act
      final result = await serverAuthWrapper(serverCall: mockServerCall);

      // arrange
      expect(result, const Left(UnauthorizedFailure()));
    });

    test("should retry the server call once (aka. call it twice in total)",
        () async {
      // act
      await serverAuthWrapper(serverCall: mockServerCall);

      // assert
      verify(() => mockServerCall(tAccessToken)).called(2);
    });
  });
}
