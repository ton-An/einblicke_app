import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/data_sources/server_remote_handler.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures.dart';
import '../../../mocks.dart';

/* To-Do:
      - [ ] Re-do "should throw the corresponding [Failure] if the request was unsuccessful" tests
*/

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
            options: any(named: "options"),
          )).thenAnswer((_) async => tGetNewTokenBundleSuccessfulResponse);
    });

    test(
        "should call the server with the provided path, the body json [String] and headers",
        () async {
      // act
      await serverRemoteHandler.post(
        path: tGetNewTokenBundleRequestPath,
        body: tGetNewTokenBundleRequestMap,
        clientId: tFakeSecrets.clientId,
        clientSecret: tFakeSecrets.clientSecret,
        accessToken: tAccessToken.token,
      );

      // assert
      final capturedOptions = verify(
        () => mockDio.post(
          any(),
          data: any(named: "data"),
          options: captureAny(named: "options"),
        ),
      ).captured.single as Options;

      expect(capturedOptions.headers, {
        "Content-Type": "application/json",
        "client_id": tFakeSecrets.clientId,
        "client_secret": tFakeSecrets.clientSecret,
        "Authorization": "Bearer ${tAccessToken.token}",
      });
    });

    test("should return the response data if the request was successful",
        () async {
      // act
      final result = await serverRemoteHandler.post(
        path: tGetNewTokenBundleRequestPath,
        body: tGetNewTokenBundleRequestMap,
      );

      // assert
      expect(result, tTokenBundleMap);
    });

    test(
        "should throw the corresponding [Failure] if the request was unsuccessful",
        () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: "data"),
          options: any(named: "options"),
        ),
      ).thenAnswer(
          (invocation) => Future.value(tGetNewTokenBundleUnsuccessfulResponse));
      when(
        () => mockFailureMapper.mapCodeToFailure(any()),
      ).thenAnswer((invocation) => const DatabaseReadFailure());

      // act
      call() => serverRemoteHandler.post(
            path: tGetNewTokenBundleRequestPath,
            body: tGetNewTokenBundleRequestMap,
          );

      // assert
      expect(call(), throwsA(const DatabaseReadFailure()));
    });
  });

  group("multipartPost()", () {
    // should throw the corresponding [Failure] if the response was unsuccessful
    setUp(() {
      when(() => mockDio.post(
            any(),
            data: any(named: "data"),
            options: any(named: "options"),
          )).thenAnswer(
        (_) async => tEmptySuccessfulResponse,
      );
    });

    test("should call the server with the provided path, formData and headers",
        () async {
      // act
      await serverRemoteHandler.multipartPost(
        path: tUploadImageRequestPath,
        formData: tFormData,
        accessToken: tAccessToken.token,
      );

      // assert
      final capturedOptions = verify(
        () => mockDio.post(
          any(),
          data: any(named: "data"),
          options: captureAny(named: "options"),
        ),
      ).captured.single as Options;

      expect(capturedOptions.headers, {
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${tAccessToken.token}",
      });
    });

    test(
        "should throw the corresponding [Failure] if the request was unsuccessful",
        () async {
      // arrange
      when(
        () => mockDio.post(
          any(),
          data: any(named: "data"),
          options: any(named: "options"),
        ),
      ).thenAnswer((invocation) => Future.value(tEmptyUnsuccessfulResponse));
      when(
        () => mockFailureMapper.mapCodeToFailure(any()),
      ).thenAnswer((invocation) => const DatabaseReadFailure());

      // act
      call() => serverRemoteHandler.multipartPost(
            path: tUploadImageRequestPath,
            formData: tFormData,
          );

      // assert
      expect(call(), throwsA(const DatabaseReadFailure()));
    });
  });

  group("get()", () {
    setUp(() {
      when(() => mockDio.get(
            any(),
            options: any(named: "options"),
          )).thenAnswer((_) async => tSampleGetResponse);
    });

    test("should call the server with the provided path and headers", () async {
      // act
      await serverRemoteHandler.get(
        path: tSampleGetRequestPath,
        accessToken: tAccessToken.token,
      );

      // assert
      final capturedOptions = verify(
        () => mockDio.get(
          any(),
          options: captureAny(named: "options"),
        ),
      ).captured.single as Options;

      expect(capturedOptions.headers, {
        "Authorization": "Bearer ${tAccessToken.token}",
      });
    });

    test("should return the response data if the request was successful",
        () async {
      // act
      final result = await serverRemoteHandler.get(
        path: tSampleGetRequestPath,
        accessToken: tAccessToken.token,
      );

      // assert
      expect(result, tSampleGetResponseMap);
    });

    test(
        "should throw the corresponding [Failure] if the request was unsuccessful",
        () async {
      // arrange
      when(
        () => mockDio.get(
          any(),
          options: any(named: "options"),
        ),
      ).thenAnswer((invocation) => Future.value(tEmptyUnsuccessfulResponse));
      when(
        () => mockFailureMapper.mapCodeToFailure(any()),
      ).thenAnswer((invocation) => const DatabaseReadFailure());

      // act
      call() => serverRemoteHandler.get(
            path: tSampleGetRequestPath,
            accessToken: tAccessToken.token,
          );

      // assert
      expect(call(), throwsA(const DatabaseReadFailure()));
    });
  });
}
