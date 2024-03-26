import 'package:einblicke_app/features/select_frame/data/data_sources/select_frame_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures.dart';
import '../../../../mocks.dart';

void main() {
  late SelectFrameRemoteDataSource selectFrameRemoteDataSource;
  late MockServerRemoteHandler mockServerRemoteHandler;

  setUp(() {
    mockServerRemoteHandler = MockServerRemoteHandler();
    selectFrameRemoteDataSource = SelectFrameRemoteDataSourceImpl(
      serverRemoteHandler: mockServerRemoteHandler,
    );
  });

  group("getMostRecentImageOfFrame", () {
    setUp(() {
      // -- Mocks
      when(
        () => mockServerRemoteHandler.getBytes(
          path: any(named: "path"),
          accessToken: any(named: "accessToken"),
        ),
      ).thenAnswer((_) => Future.value(tImageBytes));
    });

    test(
        "should get the image [Uint8List] bytes from the server and return them",
        () async {
      // act
      await selectFrameRemoteDataSource.getMostRecentImageOfFrame(
        frameId: tFrameId,
        accessToken: tAccessToken,
      );

      // assert
      verify(
        () => mockServerRemoteHandler.getBytes(
          path: "/latest_image_of_frame?frame_id=$tFrameId",
          accessToken: tAccessToken.token,
        ),
      );
    });
  });

  group("getPairedFramesInfo", () {
    setUp(() {
      // -- Mocks
      when(
        () => mockServerRemoteHandler.get(
          path: any(named: "path"),
          accessToken: any(named: "accessToken"),
        ),
      ).thenAnswer((_) => Future.value(tPairedFrameInfosJson));
    });

    test("should get the paired frames info from the server and return them",
        () async {
      // act
      final result = await selectFrameRemoteDataSource.getPairedFramesInfo(
        accessToken: tAccessToken,
      );

      // assert
      expect(result, tPairedFrameInfos);
      verify(
        () => mockServerRemoteHandler.get(
          path: "/paired_frames",
          accessToken: tAccessToken.token,
        ),
      );
    });
  });
}
