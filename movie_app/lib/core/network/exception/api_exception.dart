import 'package:dio/dio.dart';

/// Custom exception class representing server-related errors.
class ApiException implements Exception {
  /// Name of the exception.
  final String name;

  /// Human-readable error message.
  final String message;

  /// HTTP status code associated with the exception, default is 500 (Internal Server Error).
  final int? statusCode;

  /// Type of the server exception.
  final ApiExceptionType exceptionType;

  ApiException._({
    required this.message,
    this.exceptionType = ApiExceptionType.unexpectedError,
    int? statusCode,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory ApiException(dynamic error) {
    late ApiException serverException;
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.requestCancelled,
              statusCode: error.response?.statusCode,
              message: 'Request to the server has been canceled',
            );
            break;

          case DioExceptionType.connectionTimeout:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.requestTimeout,
              statusCode: error.response?.statusCode,
              message: 'Connection timeout',
            );
            break;

          case DioExceptionType.receiveTimeout:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.receiveTimeout,
              statusCode: error.response?.statusCode,
              message: 'Receive timeout',
            );
            break;

          case DioExceptionType.sendTimeout:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.sendTimeout,
              statusCode: error.response?.statusCode,
              message: 'Send timeout',
            );
            break;

          case DioExceptionType.connectionError:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.connectionError,
              message: 'Connection error',
            );
            break;
          case DioExceptionType.badCertificate:
            serverException = ApiException._(
              exceptionType: ApiExceptionType.badCertificate,
              message: 'Bad certificate',
            );
            break;
          case DioExceptionType.unknown:
            if (error.error
                .toString()
                .contains(ApiExceptionType.socketException.name)) {
              serverException = ApiException._(
                statusCode: error.response?.statusCode,
                message: 'Verify your internet connection',
              );
            } else {
              serverException = ApiException._(
                exceptionType: ApiExceptionType.unexpectedError,
                statusCode: error.response?.statusCode,
                message: 'Unexpected error',
              );
            }
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.badRequest,
                  message: 'Bad request.',
                );
                break;
              case 401:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.unauthorisedRequest,
                  message: 'Authentication failure',
                );
                break;
              case 403:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.unauthorisedRequest,
                  message: 'User is not authorized to access API',
                );
                break;
              case 404:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.notFound,
                  message: 'Request resource does not exist',
                );
                break;
              case 405:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.unauthorisedRequest,
                  message: 'Operation not allowed',
                );
                break;
              case 415:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.notImplemented,
                  message: 'Media type unsupported',
                );
                break;
              case 422:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.unableToProcess,
                  message: 'validation data failure',
                );
                break;
              case 429:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.conflict,
                  message: 'too much requests',
                );
                break;
              case 500:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.internalServerError,
                  message: 'Internal server error',
                );
                break;
              case 503:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.serviceUnavailable,
                  message: 'Service unavailable',
                );
                break;
              default:
                serverException = ApiException._(
                  exceptionType: ApiExceptionType.unexpectedError,
                  message: 'Unexpected error',
                );
            }
            break;
        }
      } else {
        // Handle non-Dio exceptions
        serverException = ApiException._(
          exceptionType: ApiExceptionType.unexpectedError,
          message: 'Unexpected error',
        );
      }
    } on FormatException catch (e) {
      serverException = ApiException._(
        exceptionType: ApiExceptionType.formatException,
        message: e.message,
      );
    } on Exception catch (_) {
      serverException = ApiException._(
        exceptionType: ApiExceptionType.unexpectedError,
        message: 'Unexpected error',
      );
    }
    return serverException;
  }
}

/// Enumerates different types of server exceptions that can be handled by the application.
enum ApiExceptionType {
  requestCancelled,

  badCertificate,

  unauthorisedRequest,

  connectionError,

  badRequest,

  notFound,

  requestTimeout,

  sendTimeout,

  receiveTimeout,

  conflict,

  internalServerError,

  notImplemented,

  serviceUnavailable,

  socketException,

  formatException,

  unableToProcess,

  defaultError,

  unexpectedError,
}