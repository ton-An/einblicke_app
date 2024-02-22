// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationToken _$AuthenticationTokenFromJson(Map<String, dynamic> json) =>
    AuthenticationToken(
      token: json['token'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$AuthenticationTokenToJson(
        AuthenticationToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
