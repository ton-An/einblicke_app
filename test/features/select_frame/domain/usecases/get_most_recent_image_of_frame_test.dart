import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_most_recent_image_of_frame.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late GetMostRecentImageOfFrame getMostRecentImageOfFrame;
  late MockSelectFrameRepository mockSelectFrameRepository;
  late MockServerAuthWrapper<Uint8List> mockServerAuthWrapper;

  setUp(() {
    // -- Definitions
    mockSelectFrameRepository = MockSelectFrameRepository();
    mockServerAuthWrapper = MockServerAuthWrapper();
    getMostRecentImageOfFrame = GetMostRecentImageOfFrame(
      selectFrameRepository: mockSelectFrameRepository,
      serverAuthWrapper: mockServerAuthWrapper,
    );

    // -- Stubs
    when(
      () => mockServerAuthWrapper(
        serverCall: any(named: "serverCall"),
      ),
    ).thenAnswer((invocation) => Future.value(Right(tImageBytes)));
    when(
      () => mockSelectFrameRepository.getMostRecentImageOfFrame(
        frameId: any(named: "frameId"),
        accessToken: any(named: "accessToken"),
      ),
    ).thenAnswer((_) => Future.value(Right(tImageBytes)));
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  test(
      "should get the most recent image of a frame and return the [Uint8List] image bytes",
      () async {
    // act & assert
    final result = await getMostRecentImageOfFrame(frameId: tFrameId);

    final verificationResult = verify(
      () => mockServerAuthWrapper(
        serverCall: captureAny(named: "serverCall"),
      ),
    );

    final Function serverCallClosure = verificationResult.captured[0];

    await serverCallClosure(tAccessToken);

    // assert
    verify(
      () => mockSelectFrameRepository.getMostRecentImageOfFrame(
        frameId: tFrameId,
        accessToken: tAccessToken,
      ),
    );
    expect(result, Right(tImageBytes));
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
    final result = await getMostRecentImageOfFrame(frameId: tFrameId);

    // assert
    expect(result, const Left(DatabaseReadFailure()));
  });
}
