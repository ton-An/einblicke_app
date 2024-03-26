import 'package:dio/dio.dart';
import 'package:einblicke_app/core/data/data_sources/server_remote_handler.dart';
import 'package:einblicke_app/core/data/repository_impl/repository_failure_handler.dart';
import 'package:einblicke_app/core/secrets.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:einblicke_app/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:einblicke_app/features/authentication/data/repository_implementation/authentication_repository_impl.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/is_signed_in.dart';
import 'package:einblicke_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_status_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_cubit.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
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

  // =+=+ Shared +=+= //
  getIt.registerLazySingleton(() => FailureMapper());

  // =+=+ Core +=+= //
  _registerCore();

  // =+=+ Authentication +=+= //
  _registerAuthentication();
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

  // -- Presentation -- //
  getIt.registerFactory(() => AuthenticationStatusCubit(isSignedIn: getIt()));
  getIt.registerFactory(
    () => SignInCubit(
      signInUsecase: getIt(),
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
