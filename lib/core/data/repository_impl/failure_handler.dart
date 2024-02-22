import 'package:dio/dio.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

class FailureHandler {
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
        return const UnkownServerRequestFailure();
    }
  }
}
