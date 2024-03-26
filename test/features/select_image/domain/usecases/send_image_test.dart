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
  late MockServerAuthWrapper<None> mockServerAuthWrapper;

  setUp(() {
    // -- Definitions
    mockSelectImageRepository = MockSelectImageRepository();
    mockServerAuthWrapper = MockServerAuthWrapper();
    sendImage = SendImage(
      selectImageRepository: mockSelectImageRepository,
      serverAuthWrapper: mockServerAuthWrapper,
    );

    // -- Stubs
    when(
      () => mockServerAuthWrapper(
        serverCall: any(named: "serverCall"),
      ),
    ).thenAnswer((invocation) => Future.value(const Right(None())));
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

  test("should send the image to the server and return [None]", () async {
    // act & assert
    final result = await sendImage(imagePath: tImagePath, frameId: tFrameId);

    final verificationResult = verify(
      () => mockServerAuthWrapper(
        serverCall: captureAny(named: "serverCall"),
      ),
    );

    final Function serverCallClosure = verificationResult.captured[0];

    await serverCallClosure(tAccessToken);

    // assert
    verify(
      () => mockSelectImageRepository.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      ),
    );
    expect(result, const Right(None()));
  });

  test("should relay [Failure]s", () async {
    // arrange
    when(
      () => mockServerAuthWrapper(
        serverCall: any(named: "serverCall"),
      ),
    ).thenAnswer(
        (invocation) => Future.value(const Left(DatabaseReadFailure())));

    // act
    final result = await sendImage(imagePath: tImagePath, frameId: tFrameId);

    // assert
    expect(result, const Left(DatabaseReadFailure()));
  });
}
