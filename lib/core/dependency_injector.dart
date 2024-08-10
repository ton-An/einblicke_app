import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_status_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/select_frame/data/data_sources/select_frame_remote_data_source.dart';
import 'package:einblicke_app/features/select_frame/data/repository_implementations/select_frame_repository_impl.dart';
import 'package:einblicke_app/features/select_frame/domain/repositories/select_frame_repository.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_most_recent_image_of_frame.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_paired_frames_info.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/single_image_loader_cubit/single_image_loader_cubit.dart';
import 'package:einblicke_app/features/select_image/data/data_sources/select_image_remote_data_source.dart';
import 'package:einblicke_app/features/select_image/data/repository_implementation/select_image_repository_impl.dart';
import 'package:einblicke_app/features/select_image/domain/repositories/select_image_repository.dart';
import 'package:einblicke_app/features/select_image/domain/usecases/send_image.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_cubit.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

/*
  To-Dos:
  - [ ] Revamp to make strucutre clearer (will become more important as the app grows)
*/

final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton(() => ImagePicker());

  // =+=+ 3rd Party +=+= //
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: "${getIt<Secrets>().serverUrl}/curator",
        validateStatus: (status) => true,
        // validateStatus: (_) => true,
      ),
    ),
  );
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton<FileSystem>(() => const LocalFileSystem());

  // =+=+ Shared +=+= //
  getIt.registerLazySingleton(() => const FailureMapper());

  // =+=+ Core +=+= //
  _registerCore();

  // =+=+ Authentication +=+= //
  _registerAuthentication();

  // =+=+ Select Frame +=+= //
  _registerSelectFrame();

  // =+=+ Select Image +=+= //
  _registerSelectImage();
}

void _registerCore() {
  getIt.registerLazySingleton<Secrets>(() => const SecretsImpl());

  // -- Data -- //
  getIt.registerLazySingleton(
    () => ServerRemoteHandler(dio: getIt(), failureMapper: getIt()),
  );
  getIt.registerLazySingleton(() => const RepositoryFailureHandler());

  // -- Presentation -- //
  getIt.registerFactory(() => InAppNotificationCubit());
}

void _registerAuthentication() {
  // -- Data -- //
  getIt.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(
      secureStorage: getIt(),
    ),
  );
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      serverRemoteHandler: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationLocalDataSource: getIt(),
      authenticationRemoteDataSource: getIt(),
      failureHandler: getIt(),
    ),
  );

  // -- Domain -- //
  getIt.registerLazySingleton(
      () => SignIn(authenticationRepository: getIt(), secrets: getIt()));
  getIt.registerLazySingleton(
      () => IsSingnedIn(authenticationRepository: getIt()));
  getIt.registerLazySingleton(
      () => RefreshTokenBundle(authenticationRepository: getIt()));

  // -- Presentation -- //
  getIt.registerFactory(() => AuthenticationStatusCubit(isSignedIn: getIt()));
  getIt.registerFactory(
    () => SignInCubit(
      signInUsecase: getIt(),
    ),
  );
}

void _registerSelectFrame() {
  // -- Data -- //
  getIt.registerLazySingleton<SelectFrameRemoteDataSource>(
    () => SelectFrameRemoteDataSourceImpl(
      serverRemoteHandler: getIt(),
    ),
  );

  getIt.registerLazySingleton<SelectFrameRepository>(
    () => SelectFrameRepositoryImpl(
      selectFrameRemoteDataSource: getIt(),
      failureHandler: getIt(),
    ),
  );

  // -- Domain -- //
  getIt.registerLazySingleton(
    () => ServerAuthWrapper<Uint8List>(
      authenticationRepository: getIt(),
      refreshTokenBundle: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetMostRecentImageOfFrame(
      selectFrameRepository: getIt(), serverAuthWrapper: getIt()));
  getIt.registerLazySingleton(
    () => ServerAuthWrapper<List<PairedFrameInfo>>(
      authenticationRepository: getIt(),
      refreshTokenBundle: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => GetPairedFramesInfo(
      selectFrameRepository: getIt(), serverAuthWrapper: getIt()));

  // -- Presentation -- //
  getIt.registerFactory(() => SelectFrameCubit(getPairedFramesInfo: getIt()));
  getIt.registerFactory(
    () => SingleImageLoaderCubit(
      getMostRecentImageOfFrame: getIt(),
    ),
  );
}

void _registerSelectImage() {
  // -- Data -- //
  getIt.registerLazySingleton<SelectImageRemoteDataSource>(
    () => SelectImageRemoteDataSourceImpl(
      serverRemoteHandler: getIt(),
      fileSystem: getIt(),
    ),
  );
  getIt.registerLazySingleton<SelectImageRepository>(
    () => SelectImageRepositoryImpl(
      selectImageRemoteDataSource: getIt(),
      failureHandler: getIt(),
    ),
  );

  // -- Domain -- //
  getIt.registerFactory(
    () => SendImage(
      selectImageRepository: getIt(),
      serverAuthWrapper: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => ServerAuthWrapper<None>(
      authenticationRepository: getIt(),
      refreshTokenBundle: getIt(),
    ),
  );

  // -- Presentation -- //
  getIt.registerFactory(
    () => SelectImageCubit(
      sendImageUsecase: getIt(),
    ),
  );
}
