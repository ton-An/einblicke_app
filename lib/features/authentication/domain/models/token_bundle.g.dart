// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBundle _$TokenBundleFromJson(Map<String, dynamic> json) => TokenBundle(
      accessToken: AuthenticationToken.fromJson(
          json['accessToken'] as Map<String, dynamic>),
      refreshToken: AuthenticationToken.fromJson(
          json['refreshToken'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenBundleToJson(TokenBundle instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
