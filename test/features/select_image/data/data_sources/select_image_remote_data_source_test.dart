import 'package:dio/dio.dart';
import 'package:einblicke_app/features/select_image/data/data_sources/select_image_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late SelectImageRemoteDataSourceImpl selectImageRemoteDataSourceImpl;
  late MockServerRemoteHandler mockServerRemoteHandler;
  late MockFileSystem mockFileSystem;

  setUp(() {
    // -- Definitions
    mockServerRemoteHandler = MockServerRemoteHandler();
    mockFileSystem = MockFileSystem();
    selectImageRemoteDataSourceImpl = SelectImageRemoteDataSourceImpl(
      serverRemoteHandler: mockServerRemoteHandler,
      fileSystem: mockFileSystem,
    );
  });

  setUpAll(() {
    // -- Fallbacks
    registerFallbackValue(tFormData);
  });

  group("sendImage()", () {
    setUp(() {
      // -- Definitions
      when(() => mockFileSystem.file(tImagePath)).thenReturn(tMockImageFile);
      when(() => tMockImageFile.readAsBytes())
          .thenAnswer((_) async => tImageBytes);
      when(() => mockServerRemoteHandler.multipartPost(
            path: any(named: "path"),
            formData: any(named: "formData"),
            headers: any(named: "headers"),
          )).thenAnswer(
        (_) async => Future.value(),
      );
    });

    test("should get the image [File]", () async {
      // act
      await selectImageRemoteDataSourceImpl.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      verify(() => mockFileSystem.file(tImagePath).readAsBytes());
    });

    test("should send the image to the server", () async {
      // act
      await selectImageRemoteDataSourceImpl.sendImage(
        imagePath: tImagePath,
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      verify(
        () => mockServerRemoteHandler.multipartPost(
          path: "/curator/upload_image",
          formData: any(named: "formData", that: isA<FormData>()),
          headers: {
            "Authorization": "Bearer $tAccessTokenString",
          },
        ),
      );
    });
  });
}
