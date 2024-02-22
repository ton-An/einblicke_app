import 'package:einblicke_app/features/authentication/domain/models/authentication_token.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_bundle.g.dart';

@JsonSerializable()

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

  factory TokenBundle.fromJson(Map<String, dynamic> json) =>
      _$TokenBundleFromJson(json);

  Map<String, dynamic> toJson() => _$TokenBundleToJson(this);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
