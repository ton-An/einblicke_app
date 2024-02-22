import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/refresh_token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late RefreshTokenBundle refreshTokenBundle;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    // -- Definitions
    mockAuthenticationRepository = MockAuthenticationRepository();
    refreshTokenBundle = RefreshTokenBundle(
      authenticationRepository: mockAuthenticationRepository,
    );

    // -- Stubs
    when(() => mockAuthenticationRepository.getTokenBundleFromStorage())
        .thenAnswer((_) async => Right(tTokenBundle));
    when(() => mockAuthenticationRepository.getNewTokenBundle(
        refreshToken: any(named: "refreshToken"))).thenAnswer(
      (_) async => Right(tTokenBundle),
    );
    when(() => mockAuthenticationRepository.saveTokenBundle(
          tokenBundle: any(named: "tokenBundle"),
        )).thenAnswer(
      (_) async => const Right(None()),
    );
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tTokenBundle);
    registerFallbackValue(tAccessToken);
  });

  test("should get the user's refresh token", () async {
    // act
    await refreshTokenBundle();

    // assert
    verify(() => mockAuthenticationRepository.getTokenBundleFromStorage());
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(() => mockAuthenticationRepository.getTokenBundleFromStorage())
        .thenAnswer((_) async => const Left(StorageReadFailure()));

    // act
    final result = await refreshTokenBundle();

    // assert
    expect(result, const Left(StorageReadFailure()));
  });

  test("should refresh the user's [TokenBundle]", () async {
    // act
    await refreshTokenBundle();

    // assert
    verify(() => mockAuthenticationRepository.getNewTokenBundle(
        refreshToken: tRefreshToken));
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(() => mockAuthenticationRepository.getNewTokenBundle(
            refreshToken: any(named: "refreshToken")))
        .thenAnswer((_) async => const Left(ServerConnectionFailure()));

    // act
    final result = await refreshTokenBundle();

    // assert
    expect(result, const Left(ServerConnectionFailure()));
  });

  test("should save the refreshed [TokenBundle]", () async {
    // act
    await refreshTokenBundle();

    // assert
    verify(() => mockAuthenticationRepository.saveTokenBundle(
        tokenBundle: tTokenBundle));
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(() => mockAuthenticationRepository.saveTokenBundle(
          tokenBundle: any(named: "tokenBundle"),
        )).thenAnswer(
      (_) async => const Left(SecureStorageWriteFailure()),
    );

    // act
    final result = await refreshTokenBundle();

    // assert
    expect(result, const Left(SecureStorageWriteFailure()));
  });
}
