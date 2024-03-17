import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/data/repository_implementation/authentication_repository_impl.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;
  late MockAuthenticationLocalDataSource mockLocalDataSource;
  late MockAuthenticationRemoteDataSource mockRemoteDataSource;
  late MockFailureHandler mockFailureHandler;

  setUp(() {
    // -- Definitions
    mockLocalDataSource = MockAuthenticationLocalDataSource();
    mockRemoteDataSource = MockAuthenticationRemoteDataSource();
    mockFailureHandler = MockFailureHandler();
    authenticationRepositoryImpl = AuthenticationRepositoryImpl(
      authenticationLocalDataSource: mockLocalDataSource,
      authenticationRemoteDataSource: mockRemoteDataSource,
      failureHandler: mockFailureHandler,
    );
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tTokenBundle);
    registerFallbackValue(tDioException);
    registerFallbackValue(tAccessToken);
    registerFallbackValue(tFakeSecrets);
  });

  group("deleteTokens()", () {
    setUp(
      () {
        when(() => mockLocalDataSource.deleteTokens())
            .thenAnswer((_) => Future.value());
      },
    );

    test(
        "should delete the [TokenBundle] from the device's secure storage and return [None]",
        () async {
      // act
      final result = await authenticationRepositoryImpl.deleteTokens();

      // assert
      expect(result, const Right(None()));
      verify(() => mockLocalDataSource.deleteTokens());
    });

    test(
        "should return a [SecureStorageWriteFailure] when deleting the [TokenBundle] throws a [PlatformException]",
        () async {
      // arrange
      when(() => mockLocalDataSource.deleteTokens())
          .thenThrow(tPlatformException);

      // act
      final result = await authenticationRepositoryImpl.deleteTokens();

      // assert
      expect(result, const Left(SecureStorageWriteFailure()));
    });
  });

  group("getTokenBundleFromStorage()", () {
    setUp(
      () {
        when(() => mockLocalDataSource.getTokenBundle())
            .thenAnswer((_) async => tTokenBundle);
      },
    );

    test(
        "should retrieve the [TokenBundle] from the device's secure storage and return it",
        () async {
      // act
      final result =
          await authenticationRepositoryImpl.getTokenBundleFromStorage();

      // assert
      expect(result, Right(tTokenBundle));
      verify(() => mockLocalDataSource.getTokenBundle());
    });

    test(
        "should return a [SecureStorageReadFailure] if getting the [TokenBundle] returns [null]",
        () async {
      // arrange
      when(() => mockLocalDataSource.getTokenBundle())
          .thenAnswer((_) async => null);

      // act
      final result =
          await authenticationRepositoryImpl.getTokenBundleFromStorage();

      // assert
      expect(result, const Left(SecureStorageReadFailure()));
    });

    test(
        "should return a [SecureStorageReadFailure] when getting the [TokenBundle] throws a [PlatformException]",
        () async {
      // arrange
      when(() => mockLocalDataSource.getTokenBundle())
          .thenThrow(tPlatformException);

      // act
      final result =
          await authenticationRepositoryImpl.getTokenBundleFromStorage();

      // assert
      expect(result, const Left(SecureStorageReadFailure()));
    });
  });

  group("isTokenBundlePresent()", () {
    setUp(
      () {
        when(() => mockLocalDataSource.isTokenBundlePresent())
            .thenAnswer((_) async => true);
      },
    );

    test("should check if the [TokenBundle] is present and return the result",
        () async {
      // act
      final result = await authenticationRepositoryImpl.isTokenBundlePresent();

      // assert
      expect(result, const Right(true));
      verify(() => mockLocalDataSource.isTokenBundlePresent());
    });

    test(
        "should return a [SecureStorageReadFailure] when the local data source throws a [PlatformException]",
        () async {
      // arrange
      when(() => mockLocalDataSource.isTokenBundlePresent())
          .thenThrow(tPlatformException);

      // act
      final result = await authenticationRepositoryImpl.isTokenBundlePresent();

      // assert
      expect(result, const Left(SecureStorageReadFailure()));
      verify(() => mockLocalDataSource.isTokenBundlePresent());
    });
  });

  group("saveTokenBundle()", () {
    setUp(
      () {
        when(() => mockLocalDataSource.saveTokenBundle(
              tokenBundle: any(named: "tokenBundle"),
            )).thenAnswer((_) => Future.value());
      },
    );

    test(
        "should save the provided [TokenBundle] to the device's secure storage and return [None]",
        () async {
      // act
      final result = await authenticationRepositoryImpl.saveTokenBundle(
          tokenBundle: tTokenBundle);

      // assert
      expect(result, const Right(None()));
      verify(
        () => mockLocalDataSource.saveTokenBundle(
          tokenBundle: tTokenBundle,
        ),
      );
    });

    test(
        "should return a [SecureStorageWriteFailure] when saving the [TokenBundle] throws a [PlatformException]",
        () async {
      // arrange
      when(() => mockLocalDataSource.saveTokenBundle(
              tokenBundle: any(named: "tokenBundle")))
          .thenThrow(tPlatformException);

      // act
      final result = await authenticationRepositoryImpl.saveTokenBundle(
        tokenBundle: tTokenBundle,
      );

      // assert
      expect(result, const Left(SecureStorageWriteFailure()));
    });
  });

  group("signIn()", () {
    setUp(
      () {
        when(() => mockRemoteDataSource.signIn(
              username: any(named: "username"),
              password: any(named: "password"),
              secrets: any(named: "secrets"),
            )).thenAnswer((_) async => tTokenBundle);
      },
    );

    test(
        "should sign in the user and return the new [TokenBundle] from the remote data source",
        () async {
      // act
      final result = await authenticationRepositoryImpl.signIn(
        username: tUsername,
        password: tPassword,
        secrets: tFakeSecrets,
      );

      // assert
      expect(result, Right(tTokenBundle));
      verify(
        () => mockRemoteDataSource.signIn(
          username: tUsername,
          password: tPassword,
          secrets: tFakeSecrets,
        ),
      );
    });

    test("should re-map [DioException]s if they are thrown", () async {
      // arrange
      when(() => mockRemoteDataSource.signIn(
            username: any(named: "username"),
            password: any(named: "password"),
            secrets: any(named: "secrets"),
          )).thenThrow(tDioException);
      when(
        () => mockFailureHandler.dioExceptionMapper(any()),
      ).thenAnswer((invocation) => tMappedDioFailure);

      // act
      final result = await authenticationRepositoryImpl.signIn(
        username: tUsername,
        password: tPassword,
        secrets: tFakeSecrets,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });

    test("should re-throw exceptions that are not accounted for", () async {
      // arrange
      when(() => mockRemoteDataSource.signIn(
            username: any(named: "username"),
            password: any(named: "password"),
            secrets: any(named: "secrets"),
          )).thenThrow(Exception());

      // act
      final call = authenticationRepositoryImpl.signIn;

      // assert
      expect(
        () => call(
          username: tUsername,
          password: tPassword,
          secrets: tFakeSecrets,
        ),
        throwsException,
      );
    });
  });

  group("getNewTokenBundle()", () {
    setUp(
      () {
        when(() => mockRemoteDataSource.getNewTokenBundle(
              refreshToken: any(named: "refreshToken"),
            )).thenAnswer((_) async => tTokenBundle);
      },
    );

    test("should get a new [TokenBundle] and return it", () async {
      // act
      final result = await authenticationRepositoryImpl.getNewTokenBundle(
        refreshToken: tRefreshToken,
      );

      // assert
      expect(result, Right(tTokenBundle));
      verify(
        () => mockRemoteDataSource.getNewTokenBundle(
          refreshToken: tRefreshToken,
        ),
      );
    });

    test("should re-map [DioException]s if they are thrown", () async {
      // arrange
      when(() => mockRemoteDataSource.getNewTokenBundle(
            refreshToken: any(named: "refreshToken"),
          )).thenThrow(tDioException);
      when(
        () => mockFailureHandler.dioExceptionMapper(any()),
      ).thenAnswer((invocation) => tMappedDioFailure);

      // act
      final result = await authenticationRepositoryImpl.getNewTokenBundle(
        refreshToken: tRefreshToken,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });

    test("should re-throw exceptions that are not accounted for", () async {
      // arrange
      when(() => mockRemoteDataSource.getNewTokenBundle(
            refreshToken: any(named: "refreshToken"),
          )).thenThrow(Exception());

      // act
      final call = authenticationRepositoryImpl.getNewTokenBundle;

      // assert
      expect(
        () => call(
          refreshToken: tRefreshToken,
        ),
        throwsException,
      );
    });
  });
}
