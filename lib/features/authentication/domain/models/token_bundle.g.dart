// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBundle _$TokenBundleFromJson(Map<String, dynamic> json) => TokenBundle(
      accessToken: AuthenticationToken.fromJson(
          json['access_token'] as Map<String, dynamic>),
      refreshToken: AuthenticationToken.fromJson(
          json['refresh_token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenBundleToJson(TokenBundle instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken.toJson(),
      'refresh_token': instance.refreshToken.toJson(),
    };
