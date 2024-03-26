import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template server_remote_handler}
/// __Server Remote Handler__ is a Einblicke specific wrapper for [Dio] to handle server requests and responses.
/// {@endtemplate}
class ServerRemoteHandler {
  final Dio dio;
  final FailureMapper failureMapper;

  const ServerRemoteHandler({
    required this.dio,
    required this.failureMapper,
  });

  /// Sends a POST request to the server
  ///
  /// Parameters:
  /// - [String]: path on the server
  /// - [Map<String, dynamic>]: body
  /// - [Map<String, dynamic>]: headers
  ///
  /// Returns:
  /// - [Map<String, dynamic>?]: response body (if any)
  ///
  /// Throws:
  /// - [Failure]
  /// - [DioException]
  Future<Map<String, dynamic>> post({
    required String path,
    required Map<String, dynamic> body,
    String? clientSecret,
    String? clientId,
    String? accessToken,
  }) async {
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      if (clientSecret != null) "client_secret": clientSecret,
      if (clientId != null) "client_id": clientId,
      if (accessToken != null) "Authorization": "Bearer $accessToken"
    };

    final String requestDataString = jsonEncode(body);

    final Response response = await dio.post(path,
        data: requestDataString, options: Options(headers: headers));

    final Map<String, dynamic> responseBody = jsonDecode(response.data);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      final Failure failure =
          failureMapper.mapCodeToFailure(responseBody["code"]);

      throw failure;
    }
  }

  /// Sends a Multipart POST request to the server
  ///
  /// Parameters:
  /// - [String]: path on the server
  /// - [FormData]: formData
  /// - [Map<String, dynamic>]: headers
  ///
  /// Throws:
  /// - [Failure]
  /// - [DioException]
  Future<void> multipartPost({
    required String path,
    required FormData formData,
    String? accessToken,
  }) async {
    // headers["Content-Type"] = "multipart/form-data";
    final Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      if (accessToken != null) "Authorization": "Bearer $accessToken"
    };

    final Response response = await dio.post(path,
        data: formData, options: Options(headers: headers));

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.data);
      final Failure failure =
          failureMapper.mapCodeToFailure(responseBody["code"]);

      throw failure;
    }
  }
}
