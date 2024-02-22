import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_token.g.dart';

@JsonSerializable()

/// __Authentication Token__
///
/// A model containing a [token] for authenticating with the API and an
/// [expiresAt] date for when the token expires.
class AuthenticationToken extends Equatable {
  const AuthenticationToken({
    required this.token,
    required this.expiresAt,
  });

  final String token;
  final DateTime expiresAt;

  factory AuthenticationToken.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationTokenToJson(this);

  @override
  List<Object?> get props => [token, expiresAt];
}
