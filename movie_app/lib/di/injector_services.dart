import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/di/injector.dart';

import '../core/config/config.dart';

Future<void> initializeServices() async {
  //Logger
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(),
    ),
  );

  final config = await _loadConfig(getIt<Logger>());

  //DioClient
  getIt.registerSingleton<DioClient>(DioClient(apiKey: config.apiKey));

  //MovieService
  getIt.registerSingleton<MovieService>(
    MovieService(
      apiClient: getIt<DioClient>(),
    ),
  );
}

Future<Config> _loadConfig(Logger log) async {
  String raw;

  try {
    raw = await rootBundle.loadString('assets/config/config.json');
    final config = json.decode(raw) as Map<String, dynamic>;

    return Config(
      apiKey: config['apiKey'] as String,
    );
  } catch (e) {
    log.e(
      'Error while loading project configuration, please make sure'
      'that the file located at /assets/config/config.json'
      'exists and that it contains the correct configuration.',
      error: e,
    );
    rethrow;
  }
}
