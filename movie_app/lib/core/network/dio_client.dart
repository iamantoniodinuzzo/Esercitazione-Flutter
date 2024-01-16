import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/network/api_endpoints.dart';
import 'package:movie_app/core/network/interceptor/logger_interceptor.dart';
import 'package:movie_app/core/util/constants.dart';

/// Useful resource https://medium.com/@huguesarnold/networking-with-dio-how-to-develop-a-feature-in-flutter-project-part-4-eb6e0f3beef6
class DioClient {
  late final Dio _dio;
  static const String _baseUrl = ApiEndpoints.baseUrl;

  DioClient({required String apiKey})
      : _dio = Dio(
          BaseOptions(
              baseUrl: _baseUrl,
              queryParameters: {
                'api_key': apiKey,
              },
              connectTimeout:
                  const Duration(milliseconds: Constants.connectTimeout),
              receiveTimeout:
                  const Duration(milliseconds: Constants.receiveTimeout),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json),
        )..interceptors.addAll([
            if (kDebugMode) LoggerInterceptor(),
          ]);

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
