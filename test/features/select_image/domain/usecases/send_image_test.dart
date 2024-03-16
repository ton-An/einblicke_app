import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_image/domain/usecases/send_image.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

/* To-Do:
    - [ ] make "should relay [Failure]s" test descriptions clearer (goes for all test in this app)
    - [ ] standardize comments in test files
*/

void main() {
  late SendImage sendImage;
  late MockSelectImageRepository mockSelectImageRepository;
  late MockRefreshTokenBundle mockRefreshTokenBundle;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    // -- Definitions
    mockSelectImageRepository = MockSelectImageRepository();
    mockRefreshTokenBundle = MockRefreshTokenBundle();
    mockAuthenticationRepository = MockAuthenticationRepository();
    sendImage = SendImage(
      selectImageRepository: mockSelectImageRepository,
      refreshTokenBundle: mockRefreshTokenBundle,
      authenticationRepository: mockAuthenticationRepository,
    );

    // -- Stubs
    when(
      () => mockAuthenticationRepository.getTokenBundleFromStorage(),
    ).thenAnswer((_) => Future.value(Right(tTokenBundle)));
    when(
      () => mockSelectImageRepository.sendImage(
        imagePath: any(named: "imagePath"),
        frameId: any(named: "frameId"),
        accessToken: any(named: "accessToken"),
      ),
    ).thenAnswer((_) => Future.value(const Right(None())));
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  test("should get the [TokenBundle] from the [AuthenticationRepository]",
      () async {
    // act
    await sendImage(imagePath: tImagePath, frameId: tFrameId);

    // assert
    verify(() => mockAuthenticationRepository.getTokenBundleFromStorage());
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(
      () => mockAuthenticationRepository.getTokenBundleFromStorage(),
    ).thenAnswer((_) => Future.value(const Left(SecureStorageReadFailure())));

    // act
    final result = await sendImage(imagePath: tImagePath, frameId: tFrameId);

    // assert
    expect(result, const Left(SecureStorageReadFailure()));
  });

  test("should send the image to the server and return [None]", () async {
    // act
    final result = await sendImage(imagePath: tImagePath, frameId: tFrameId);

    // assert
    expect(result, const Right(None()));
    verify(
      () => mockSelectImageRepository.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      ),
    );
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(
      () => mockSelectImageRepository.sendImage(
        imagePath: any(named: "imagePath"),
        frameId: any(named: "frameId"),
        accessToken: any(named: "accessToken"),
      ),
    ).thenAnswer(
        (invocation) => Future.value(const Left(DatabaseReadFailure())));
  });

  group("if sending the [Image] returns a [UnauthorizedFailure]", () {
    setUp(() {
      // -- Stubs
      when(
        () => mockSelectImageRepository.sendImage(
          imagePath: any(named: "imagePath"),
          frameId: any(named: "frameId"),
          accessToken: any(named: "accessToken"),
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
      await sendImage(imagePath: tImagePath, frameId: tFrameId);

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
      final result = await sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
      );

      // arrange
      expect(result, const Left(UnauthorizedFailure()));
    });
  });
}
