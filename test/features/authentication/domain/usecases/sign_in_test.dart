import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late SignIn signIn;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    // -- Definitions
    mockAuthenticationRepository = MockAuthenticationRepository();
    signIn = SignIn(
      authenticationRepository: mockAuthenticationRepository,
      secrets: tFakeSecrets,
    );

    // -- Stubs
    when(() => mockAuthenticationRepository.signIn(
          username: any(named: "username"),
          password: any(named: "password"),
          secrets: any(named: "secrets"),
        )).thenAnswer(
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
    registerFallbackValue(tFakeSecrets);
  });

  test("should sign in a user using the provided username and password",
      () async {
    // act
    await signIn(username: tUsername, password: tPassword);

    // assert
    verify(
      () => mockAuthenticationRepository.signIn(
        username: tUsername,
        password: tPassword,
        secrets: tFakeSecrets,
      ),
    );
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(() => mockAuthenticationRepository.signIn(
          username: any(named: "username"),
          password: any(named: "password"),
          secrets: any(named: "secrets"),
        )).thenAnswer(
      (_) async => const Left(InvalidPasswordFailure()),
    );

    // act
    final result = await signIn(username: tUsername, password: tPassword);

    // assert
    expect(result, const Left(InvalidPasswordFailure()));
  });

  test("should save the provided [TokenBundle]", () async {
    // act
    await signIn(username: tUsername, password: tPassword);

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
    final result = await signIn(username: tUsername, password: tPassword);

    // assert
    expect(result, const Left(SecureStorageWriteFailure()));
  });

  test("should return [None] if the sign in was successful", () async {
    // act
    final result = await signIn(username: tUsername, password: tPassword);

    // assert
    expect(result, const Right(None()));
  });
}
