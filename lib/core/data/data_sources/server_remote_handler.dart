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

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> data) async {
    final String requestDataString = jsonEncode(data);

    final Response response = await dio.post(path, data: requestDataString);

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
