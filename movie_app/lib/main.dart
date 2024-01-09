// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/util/config/config.dart';
import 'package:movie_app/views/home/home_screen.dart';
import 'package:movie_app/views/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InitialData {
  final List<SingleChildWidget> providers;
  InitialData({
    required this.providers,
  });
}

Future<InitialData> _createData() async {
  //Util
  final log = Logger(
    printer: PrettyPrinter(),
    level: kDebugMode ? Level.trace : Level.off,
  );

  //Load project configuration
  final config = await _loadConfig(log);

  //Data
  final dioClient = DioClient(apiKey: config.apiKey);

  final networkMapper = NetworkMapper(log: log);
  final movieService = MovieService(
    apiClient: dioClient,
    log,
  );

  final movieRepository = MovieRepository(
    movieService: movieService,
    networkMapper: networkMapper,
  );

  //ViewModel's
  final homeViewModel =
      HomeViewModel(log: log, movieRepository: movieRepository);

//Create and return list of providers
  return InitialData(
    providers: [
      Provider<Logger>.value(value: log),
      Provider<MovieRepository>.value(value: movieRepository),
      ChangeNotifierProvider<HomeViewModel>.value(value: homeViewModel)
    ],
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await _createData();
  runApp(MainApp(
    data: data,
  ));
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

class MainApp extends StatelessWidget {
  final InitialData data;
  const MainApp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Movie App';
    return MultiProvider(
      providers: data.providers,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: HomeScreen(),
      ),
    );
  }
}
