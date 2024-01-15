import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/locators/locator.dart';
import 'package:movie_app/data/modules/services/dio_client.dart';
import 'package:movie_app/data/modules/services/movie_service.dart';
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/util/config/config.dart';

Future<void> initializeModules() async {
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(),
    ),
  );

  final config = await _loadConfig(getIt<Logger>());

  getIt.registerSingleton<DioClient>(
    DioClient(apiKey: config.apiKey),
  );
  getIt.registerSingleton<NetworkMapper>(
    NetworkMapper(
      log: getIt<Logger>(),
    ),
  );
  getIt.registerSingleton<MovieService>(
    MovieService(
      log: getIt<Logger>(),
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
