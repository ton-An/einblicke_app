import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dispatch_pi_app/core/secrets.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.dio,
    required this.secureStorage,
    required this.secrets,
  }) : super(const SignInInitial());

  final Dio dio;
  final FlutterSecureStorage secureStorage;
  final Secrets secrets;

  String username = "";
  String password = "";

  void signIn() async {
    emit(const SignInLoading());
    final String loginUri = "${secrets.serverUrl}/curator/sign_in/";

    final Map<String, String> headers = {
      "client_id": secrets.clientId,
      "client_secret": secrets.clientSecret,
    };

    final Map<String, String> body = {
      "username": username,
      "password": password,
    };

    final String bodyJson = jsonEncode(body);

    final Dio dio2 = Dio();

    dio2.options.headers = headers;
    // dio.options.contentType R= Headers.jsonContentType;

    final Response signInResponse = await dio2.post<String>(
      loginUri.toString(),
      data: bodyJson,
      onReceiveProgress: (count, total) {
        print("$count $total");
      },
      options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
          receiveTimeout: Duration(seconds: 1),
          validateStatus: (_) => true),
      onSendProgress: (count, total) => print("$count $total"),
    );

    if (signInResponse.statusCode == HttpStatus.ok) {
      final Map<String, String> tokens =
          Map.castFrom<String, dynamic, String, String>(
              jsonDecode(signInResponse.data));

      final String accessToken = tokens["access_token"]!;
      final String refreshToken = tokens["refresh_token"]!;

      await secureStorage.write(key: "access_token", value: accessToken);
      await secureStorage.write(key: "refresh_token", value: refreshToken);

      emit(const SignInSuccess());
    } else {
      emit(const SignInFailure());
      await Future.delayed(const Duration(milliseconds: 1400));
      emit(const SignInInitial());
    }
  }

  void updateUsername(String username) {
    this.username = username;
  }

  void updatePassword(String password) {
    this.password = password;
  }
}
