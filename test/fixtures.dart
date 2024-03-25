import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/services.dart';

import 'mocks.dart';

// -- Authentication
const String tUsername = "big-fudge";
const String tAnotherUsername = "small-fudge";
const String tPassword = "lillypad123";

const String tAccessTokenString = "you shall pass";
const String tRefreshTokenString = "you shall refresh";

final DateTime tAccessTokenExpiresAt = DateTime(2022, 11, 31);
final DateTime tRefreshTokenExpiresAt = DateTime(2022, 12, 31);

final AuthenticationToken tAccessToken = AuthenticationToken(
  token: tAccessTokenString,
  expiresAt: tAccessTokenExpiresAt,
);

final AuthenticationToken tRefreshToken = AuthenticationToken(
  token: tRefreshTokenString,
  expiresAt: tRefreshTokenExpiresAt,
);

final TokenBundle tTokenBundle = TokenBundle(
  accessToken: tAccessToken,
  refreshToken: tRefreshToken,
);

final Map<String, dynamic> tTokenBundleMap = tTokenBundle.toJson();

const String tTokenBundleJsonString =
    '{"access_token":{"token":"you shall pass","expires_at":"2022-12-01T00:00:00.000"},"refresh_token":{"token":"you shall refresh","expires_at":"2022-12-31T00:00:00.000"}}';

const String tDatabaseFailureJsonString =
    '{"name":"Database Read Failure","message":"An error occurred while reading from the database.","categoryCode":"database","code":"database_read_failure"}';

final Map<String, String> tGetNewTokenBundleRequestMap = {
  "refresh_token": tRefreshTokenString,
};

final Map<String, dynamic> tHeadersMap = {
  "Content-Type": "application/json",
};

final String tGetNewTokenBundleRequestString =
    jsonEncode(tGetNewTokenBundleRequestMap);

const String tGetNewTokenBundleRequestPath = "/refresh_tokens";

final Response tGetNewTokenBundleSuccessfulResponse = Response(
  data: tTokenBundleJsonString,
  requestOptions: RequestOptions(path: tGetNewTokenBundleRequestPath),
  statusCode: 200,
);

const String tUploadImageRequestPath = "/curator/upload_image";

final FormData tFormData = FormData();

final Response tEmptySuccessfulResponse = Response(
  data: null,
  requestOptions: RequestOptions(path: tUploadImageRequestPath),
  statusCode: 200,
);

final Response tEmptyUnsuccessfulResponse = Response(
  data: tDatabaseFailureJsonString,
  requestOptions: RequestOptions(path: tUploadImageRequestPath),
  statusCode: 401,
);

final Response tGetNewTokenBundleUnsuccessfulResponse = Response(
  data: tDatabaseFailureJsonString,
  requestOptions: RequestOptions(path: tGetNewTokenBundleRequestPath),
  statusCode: 500,
);

final Map<String, dynamic> tSignInRequestMap = {
  "username": tUsername,
  "password": tPassword,
};

class FakeSecret extends Secrets {
  @override
  String get clientId => "einblicke client id";

  @override
  String get clientSecret => "einblicke client secret";

  @override
  String get serverUrl => "einblicke server url";
}

final FakeSecret tFakeSecrets = FakeSecret();

final Map<String, dynamic> tSignInRequestHeaders = {
  "client_id": tFakeSecrets.clientId,
  "client_secret": tFakeSecrets.clientSecret,
};

// -- Select Image
const String tImagePath = "../../../fixtures/test_image.jpg";

const String tFrameId = "my_unique_frame";

final Uint8List tImageBytes = Uint8List.fromList([1, 2, 3, 4, 5]);

final MockFile tMockImageFile = MockFile();

// -- Select Frame
const String tPictureFrameId = "testPictureFrameId";
const String tPictureFrameId2 = "testPictureFrameId2";

const List<PairedFrameInfo> tPairedFrameInfos = [
  PairedFrameInfo(
    id: tPictureFrameId,
    name: tUsername,
  ),
  PairedFrameInfo(
    id: tPictureFrameId2,
    name: tAnotherUsername,
  ),
];

// -- Exceptions
final PlatformException tPlatformException = PlatformException(
  code: "i_am_a_teapot",
);

final DioException tDioException = DioException(
  requestOptions: RequestOptions(path: "i_am_a_teapot"),
  response: Response(
    requestOptions: RequestOptions(path: "i_am_a_teapot"),
  ),
  type: DioExceptionType.cancel,
);
const RequestCancelledFailure tMappedDioFailure = RequestCancelledFailure();
