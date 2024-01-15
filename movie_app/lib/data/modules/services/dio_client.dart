import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/network/api_endpoints.dart';
import 'package:movie_app/core/network/logging_interceptor.dart';
import 'package:movie_app/util/constants.dart';

/// Useful resource https://medium.com/@huguesarnold/networking-with-dio-how-to-develop-a-feature-in-flutter-project-part-4-eb6e0f3beef6
class DioClient {
  /// An instance of [Dio] for executing network requests.
  ///This is public will be used to mock [apiService] requests during testing
  final Dio _dio;

  DioClient({required String apiKey})
      : _dio = Dio(
          BaseOptions(
              baseUrl: ApiEndpoint.baseUrl,
              queryParameters: {
                'api_key': apiKey,
              },
              connectTimeout:
                  const Duration(milliseconds: Constants.connectTimeout),
              receiveTimeout:
                  const Duration(milliseconds: Constants.receiveTimeout),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json),
        )..interceptors.addAll(
            [
              if(!kReleaseMode) LoggingInterceptor(),
            ],
          );

 
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

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
