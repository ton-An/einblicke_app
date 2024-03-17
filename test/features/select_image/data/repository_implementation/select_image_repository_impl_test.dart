import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_image/data/repository_implementation/select_image_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late SelectImageRepositoryImpl selectImageRepositoryImpl;
  late MockSelectImageRemoteDataSource mockRemoteDataSource;
  late MockFailureHandler mockFailureHandler;

  setUp(() {
    // -- Definitions
    mockRemoteDataSource = MockSelectImageRemoteDataSource();
    mockFailureHandler = MockFailureHandler();
    selectImageRepositoryImpl = SelectImageRepositoryImpl(
      selectImageRemoteDataSource: mockRemoteDataSource,
      failureHandler: mockFailureHandler,
    );
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tAccessToken);
  });

  group("sendImage()", () {
    setUp(() {
      // -- Stubs
      when(() => mockRemoteDataSource.sendImage(
            imagePath: any(named: "imagePath"),
            frameId: any(named: "frameId"),
            accessToken: any(named: "accessToken"),
          )).thenAnswer((_) async => Future.value());
    });

    test("should send the image to the server and return [None]", () async {
      // act
      final result = await selectImageRepositoryImpl.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      expect(result, const Right(None()));
      verify(
        () => mockRemoteDataSource.sendImage(
          imagePath: tImagePath,
          frameId: tFrameId,
          accessToken: tAccessToken,
        ),
      );
    });

    test("should re-map [DioException]s to [Failure]s if they are thrown",
        () async {
      // arrange
      when(() => mockRemoteDataSource.sendImage(
            imagePath: any(named: "imagePath"),
            frameId: any(named: "frameId"),
            accessToken: any(named: "accessToken"),
          )).thenThrow(tDioException);
      when(() => mockFailureHandler.dioExceptionMapper(tDioException))
          .thenReturn(tMappedDioFailure);

      // act
      final result = await selectImageRepositoryImpl.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      expect(result, const Left(tMappedDioFailure));
      verify(() => mockFailureHandler.dioExceptionMapper(tDioException));
    });
  });
}
