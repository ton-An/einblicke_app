import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/data/repository_implementations/select_frame_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late SelectFrameRepositoryImpl selectFrameRepositoryImpl;
  late MockSelectFrameRemoteDataSource mockRemoteDataSource;
  late MockFailureHandler mockFailureHandler;

  setUp(() {
    // -- Definitions
    mockRemoteDataSource = MockSelectFrameRemoteDataSource();
    mockFailureHandler = MockFailureHandler();
    selectFrameRepositoryImpl = SelectFrameRepositoryImpl(
      selectFrameRemoteDataSource: mockRemoteDataSource,
      failureHandler: mockFailureHandler,
    );
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  group("getMostRecentImageOfFrame()", () {
    test("should return the [Uint8List] image bytes", () async {
      // arrange
      when(() => mockRemoteDataSource.getMostRecentImageOfFrame(
              frameId: any(named: "frameId"),
              accessToken: any(named: "accessToken")))
          .thenAnswer((_) async => tImageBytes);

      // act
      final result = await selectFrameRepositoryImpl.getMostRecentImageOfFrame(
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      expect(result, Right(tImageBytes));
      verify(() => mockRemoteDataSource.getMostRecentImageOfFrame(
            frameId: tFrameId,
            accessToken: tAccessToken,
          ));
    });

    test("should re-map [DioException]s to [Failure]s if they are thrown",
        () async {
      // arrange
      when(() => mockRemoteDataSource.getMostRecentImageOfFrame(
            frameId: any(named: "frameId"),
            accessToken: any(named: "accessToken"),
          )).thenThrow(tDioException);
      when(() => mockFailureHandler.dioExceptionMapper(tDioException))
          .thenReturn(tMappedDioFailure);

      // act
      final result = await selectFrameRepositoryImpl.getMostRecentImageOfFrame(
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });
  });

  group("getPairedFramesInfo()", () {
    test("should return a list of [PairedFrameInfo]s", () async {
      // arrange
      when(() => mockRemoteDataSource.getPairedFramesInfo(
              accessToken: any(named: "accessToken")))
          .thenAnswer((_) async => tPairedFrameInfos);

      // act
      final result = await selectFrameRepositoryImpl.getPairedFramesInfo(
        accessToken: tAccessToken,
      );

      // assert
      expect(result, const Right(tPairedFrameInfos));
      verify(() =>
          mockRemoteDataSource.getPairedFramesInfo(accessToken: tAccessToken));
    });

    test("should re-map [DioException]s to [Failure]s if they are thrown",
        () async {
      // arrange
      when(() => mockRemoteDataSource.getPairedFramesInfo(
          accessToken: any(named: "accessToken"))).thenThrow(tDioException);
      when(() => mockFailureHandler.dioExceptionMapper(tDioException))
          .thenReturn(tMappedDioFailure);

      // act
      final result = await selectFrameRepositoryImpl.getPairedFramesInfo(
        accessToken: tAccessToken,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });
  });
}
