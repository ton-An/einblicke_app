import 'package:dispatch_pi_app/features/authentication/domain/models/authentication_token.dart';
import 'package:dispatch_pi_app/features/authentication/domain/models/token_bundle.dart';

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
