import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [token, expiresAt];
}
