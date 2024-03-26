import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_paired_frames_info.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late GetPairedFramesInfo getPairedFramesInfo;
  late MockSelectFrameRepository mockSelectFrameRepository;
  late MockServerAuthWrapper<List<PairedFrameInfo>> mockServerAuthWrapper;

  setUp(() {
    // -- Definitions
    mockSelectFrameRepository = MockSelectFrameRepository();
    mockServerAuthWrapper = MockServerAuthWrapper();
    getPairedFramesInfo = GetPairedFramesInfo(
      selectFrameRepository: mockSelectFrameRepository,
      serverAuthWrapper: mockServerAuthWrapper,
    );

    // -- Stubs
    when(
      () => mockServerAuthWrapper(
        serverCall: any(named: "serverCall"),
      ),
    ).thenAnswer((invocation) => Future.value(const Right(tPairedFrameInfos)));
    when(
      () => mockSelectFrameRepository.getPairedFramesInfo(
        accessToken: any(named: "accessToken"),
      ),
    ).thenAnswer((_) => Future.value(const Right(tPairedFrameInfos)));
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  test("should get the most recent image of a frame and return the [File]",
      () async {
    // act & assert
    final result = await getPairedFramesInfo();

    final verificationResult = verify(
      () => mockServerAuthWrapper(
        serverCall: captureAny(named: "serverCall"),
      ),
    );

    final Function serverCallClosure = verificationResult.captured[0];

    await serverCallClosure(tAccessToken);

    // assert
    verify(
      () => mockSelectFrameRepository.getPairedFramesInfo(
        accessToken: tAccessToken,
      ),
    );
    expect(result, const Right(tPairedFrameInfos));
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
    final result = await getPairedFramesInfo();

    // assert
    expect(result, const Left(DatabaseReadFailure()));
  });
}
