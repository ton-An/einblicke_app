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

  group("getMostRecentImageOfFrame()", () {
    test("should return a [File]", () async {
      // arrange
      when(() => mockRemoteDataSource.getMostRecentImageOfFrame(
              frameId: any(named: "frameId")))
          .thenAnswer((_) async => tMockImageFile);

      // act
      final result = await selectFrameRepositoryImpl.getMostRecentImageOfFrame(
        frameId: tFrameId,
      );

      // assert
      expect(result, Right(tMockImageFile));
      verify(() => mockRemoteDataSource.getMostRecentImageOfFrame(
            frameId: tFrameId,
          ));
    });

    test("should re-map [DioException]s to [Failure]s if they are thrown",
        () async {
      // arrange
      when(() => mockRemoteDataSource.getMostRecentImageOfFrame(
          frameId: any(named: "frameId"))).thenThrow(tDioException);
      when(() => mockFailureHandler.dioExceptionMapper(tDioException))
          .thenReturn(tMappedDioFailure);

      // act
      final result = await selectFrameRepositoryImpl.getMostRecentImageOfFrame(
        frameId: tFrameId,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });
  });

  group("getPairedFramesInfo()", () {
    test("should return a list of [PairedFrameInfo]s", () async {
      // arrange
      when(() => mockRemoteDataSource.getPairedFramesInfo())
          .thenAnswer((_) async => tPairedFrameInfos);

      // act
      final result = await selectFrameRepositoryImpl.getPairedFramesInfo();

      // assert
      expect(result, const Right(tPairedFrameInfos));
      verify(() => mockRemoteDataSource.getPairedFramesInfo());
    });

    test("should re-map [DioException]s to [Failure]s if they are thrown",
        () async {
      // arrange
      when(() => mockRemoteDataSource.getPairedFramesInfo())
          .thenThrow(tDioException);
      when(() => mockFailureHandler.dioExceptionMapper(tDioException))
          .thenReturn(tMappedDioFailure);

      // act
      final result = await selectFrameRepositoryImpl.getPairedFramesInfo();

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });
  });
}
