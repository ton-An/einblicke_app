import 'package:dio/dio.dart';
import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:einblicke_app/features/authentication/domain/models/token_bundle.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/services.dart';

// -- Authentication
const String tUsername = "big-fudge";
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
