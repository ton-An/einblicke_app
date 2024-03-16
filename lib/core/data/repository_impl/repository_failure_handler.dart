import 'package:dio/dio.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template repository_failure_handler}
/// __Repository Failure Handler__ converts exceptions occurring in the repository layer to [Failure]s
/// {@endtemplate}
class RepositoryFailureHandler {
  /// {@macro repository_failure_handler}
  const RepositoryFailureHandler();

  /// Maps [DioException]s to [Failure]s
  ///
  /// Parameters:
  /// - [DioException]: exception
  ///
  /// Returns:
  /// {@template converted_dio_exceptions}
  /// - [ServerConnectionTimeoutFailure]
  /// - [ServerCertificateInvalidFailure]
  /// - [ServerResponseInvalidFailure]
  /// - [RequestCancelledFailure]
  /// - [ServerConnectionFailure]
  /// - [UnknownServerRequestFailure]
  /// {@endtemplate}
  Failure dioExceptionMapper(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout:
        return const ServerConnectionTimeoutFailure();
      case DioExceptionType.badCertificate:
        return const ServerCertificateInvalidFailure();
      case DioExceptionType.badResponse:
        return const ServerResponseInvalidFailure();
      case DioExceptionType.cancel:
        return const RequestCancelledFailure();
      case DioExceptionType.connectionError:
        return const ServerConnectionFailure();
      case DioExceptionType.unknown:
        return const UnknownServerRequestFailure();
    }
  }
}
