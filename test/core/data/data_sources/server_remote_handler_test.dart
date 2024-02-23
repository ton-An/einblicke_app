import 'package:einblicke_app/core/data/data_sources/server_remote_handler.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures.dart';
import '../../../mocks.dart';

void main() {
  late ServerRemoteHandler serverRemoteHandler;
  late MockDio mockDio;
  late MockFailureMapper mockFailureMapper;

  setUp(() {
    mockDio = MockDio();
    mockFailureMapper = MockFailureMapper();

    serverRemoteHandler = ServerRemoteHandler(
      dio: mockDio,
      failureMapper: mockFailureMapper,
    );
  });

  group("post()", () {
    setUp(() {
      when(() => mockDio.post(
            any(),
            data: any(named: "data"),
          )).thenAnswer((_) async => tGetNewTokenBundleSuccessfulResponse);
    });

    test("should call the server with the provided path and the json [String]",
        () async {
      // act
      await serverRemoteHandler.post(
          tGetNewTokenBundleRequestPath, tGetNewTokenBundleRequestMap);

      // assert
      verify(() => mockDio.post(
            tGetNewTokenBundleRequestPath,
            data: tGetNewTokenBundleRequestString,
          ));
    });

    test("should return the response data if the request was successful",
        () async {
      // act
      final result = await serverRemoteHandler.post(
          tGetNewTokenBundleRequestPath, tGetNewTokenBundleRequestMap);

      // assert
      expect(result, tTokenBundleMap);
    });

    test(
        "should throw the corresponding [Failure] if the request was unsuccessful",
        () async {
      // arrange
      when(() => mockDio.post(
                any(),
                data: any(named: "data"),
              ))
          .thenAnswer((invocation) =>
              Future.value(tGetNewTokenBundleUnsuccessfulResponse));
      when(
        () => mockFailureMapper.mapCodeToFailure(any()),
      ).thenAnswer((invocation) => const DatabaseReadFailure());

      // act
      final call = serverRemoteHandler.post;
      final result =
          call(tGetNewTokenBundleRequestPath, tGetNewTokenBundleRequestMap);

      // assert
      expect(result, throwsA(const DatabaseReadFailure()));
    });
  });
}
