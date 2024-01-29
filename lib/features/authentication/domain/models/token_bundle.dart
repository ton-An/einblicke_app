import 'package:dispatch_pi_app/features/authentication/domain/models/authentication_token.dart';
import 'package:equatable/equatable.dart';

/// __Token Bundle__
///
/// A model containing both an [accessToken] and a [refreshToken].
///
/// The access token is used to authenticate with the API and the refresh token
/// is used to refresh the access token when it expires.
class TokenBundle extends Equatable {
  const TokenBundle({
    required this.accessToken,
    required this.refreshToken,
  });

  final AuthenticationToken accessToken;
  final AuthenticationToken refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
