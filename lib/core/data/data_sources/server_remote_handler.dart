import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

class ServerRemoteHandler {
  final Dio dio;
  final FailureMapper failureMapper;

  const ServerRemoteHandler({
    required this.dio,
    required this.failureMapper,
  });

  Future<Map<String, dynamic>> post({
    required String path,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
  }) async {
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
}
