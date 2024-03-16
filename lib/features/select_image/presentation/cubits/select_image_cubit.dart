import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  SelectImageCubit({
    required this.dio,
    required this.secureStorage,
    required this.secrets,
  }) : super(const SelectImageInitial());

  final Dio dio;
  final FlutterSecureStorage secureStorage;
  final Secrets secrets;

  static const String frameId = "f48a2860-3294-4466-9786-f3b643bbb9ae";

  late File selectedImage;

  void selectImage(File image) {
    selectedImage = image;

    emit(SelectImagePicked(image: selectedImage));
  }

  void sendImage([bool hasRetried = false]) async {
    emit(SelectImageLoading(image: selectedImage));
    final String uploadImageUrl = "${secrets.serverUrl}/curator/upload_image";

    // final img.Image image = img.Image. fromBytes(
    //     width: 800,
    //     height: 400,
    //     bytes: (await selectedImage.readAsBytes()).buffer);

    // final img.Image image =
    //     img.decodeImage((await selectedImage.readAsBytes()))!;

    // final resizedImage = img.copyResize(image, width: 800, height: 480);

    FormData formData = FormData();
    // FormData.fromMap({
    //   "photo": MultipartFile.fromBytes(imageBytes),
    //   "frame_id": frameId,
    // });

    formData.fields.add(const MapEntry("frame_id", frameId));
    formData.files.add(MapEntry(
        "photo",
        await MultipartFile.fromFile(selectedImage.path,
            contentType: MediaType("image", "jpg"))));

    final String accessToken = (await secureStorage.read(
      key: "access_token",
    ))!;

    // dio.options.contentType = Headers.multipartFormDataContentType;
    dio.options.headers = {
      "Authorization": "Bearer $accessToken",
      Headers.contentTypeHeader: "multipart/form-data"
    };

    Response sendImageResponse = await dio.post(uploadImageUrl,
        data: formData, options: Options(validateStatus: (_) => true));

    if (sendImageResponse.statusCode == HttpStatus.ok) {
      emit(SelectImageSuccess(image: selectedImage));
      _resetForm();
    } else if (sendImageResponse.statusCode == HttpStatus.unauthorized &&
        !hasRetried) {
      refreshTokens();
      sendImage();
    } else {
      emit(const SelectImageFailure());
      _resetForm();
    }
  }

  void _resetForm() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    emit(const SelectImageInitial());
  }

  void refreshTokens() async {
    dio.options.headers = null;
    dio.options.contentType = Headers.jsonContentType;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.sendTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);

    final String refreshTokensUri =
        "${secrets.serverUrl}/curator/refresh_tokens/";

    String refreshToken = (await secureStorage.read(key: "refresh_token"))!;
    final Map<String, String> body = {
      "refresh_token": refreshToken,
    };

    final String bodyJson = jsonEncode(body);

    final Response refreshTokenResponse = await dio.post(
        refreshTokensUri.toString(),
        data: bodyJson,
        options: Options(validateStatus: (_) => true));

    if (refreshTokenResponse.statusCode == HttpStatus.ok) {
      final Map<String, String> tokens =
          Map.castFrom<String, dynamic, String, String>(
              jsonDecode(refreshTokenResponse.data));

      final String accessToken = tokens["access_token"]!;
      final String refreshToken = tokens["refresh_token"]!;

      await secureStorage.write(key: "access_token", value: accessToken);
      await secureStorage.write(key: "refresh_token", value: refreshToken);
      sendImage(true);
    } else {
      await secureStorage.deleteAll();
      emit(const SelectImageAuthFailure());
    }
  }
}
