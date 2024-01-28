import 'package:dio/dio.dart';
import 'package:dispatch_pi_app/core/secrets.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

/*
  To-Dos:
  - [ ] Revamp to make strucutre clearer (will become more important as the app grows)
*/

final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerFactory(() => Dio());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => ImagePicker());

  getIt.registerLazySingleton<Secrets>(() => const SecretsImpl());

  getIt.registerFactory(
    () => SignInCubit(
      dio: getIt(),
      secureStorage: getIt(),
      secrets: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SelectImageCubit(
      dio: getIt(),
      secureStorage: getIt(),
      secrets: getIt(),
    ),
  );
}
