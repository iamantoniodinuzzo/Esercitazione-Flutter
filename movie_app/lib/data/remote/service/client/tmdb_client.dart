// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/util/constants.dart';

class TmdbClient {
  static const String _baseUrl = Constants.baseUrl;
  final String apiKey;
  final Logger logger;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ),
  );

  TmdbClient({
    required this.apiKey,
    required this.logger,
  }) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) {
          logger.d(log);
        },
      ),
    );
  }

//Aggiunge di default la apiKey alla chiamata
  Map<String, dynamic>? _addApiKey(Map<String, dynamic>? params) {
    final Map<String, dynamic> newParams = params ?? {};
    newParams['api_key'] = apiKey;
    return newParams;
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: _addApiKey(queryParameters),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
