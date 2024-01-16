// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/theme.dart';
import 'package:movie_app/core/routes/go_router_config.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class InitialData {
  final List<SingleChildWidget> providers;

  InitialData({
    required this.providers,
  });
}

Future<InitialData> _createData() async {
  


//Create and return list of providers
  return InitialData(
    providers: [
      // Provider<Logger>.value(value: log),
      // Provider<MovieRepositoryImpl>.value(value: movieRepository),
      // ChangeNotifierProvider<HomeViewModel>.value(value: homeViewModel),
      // ChangeNotifierProvider<DetailViewModel>.value(value: detailViewModel),
      // ChangeNotifierProvider<SearchViewModel>.value(value: searchViewModel),
      // ChangeNotifierProvider<FilterableScreenViewModel>.value(
      //     value: filterableViewModel),
    ],
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await _createData();
  //TODO: Decommenta la riga successiva rimuovendo anche il _createData
  //serviceLocatorInitialization();
  runApp(MainApp(
    data: data,
  ));
}

class MainApp extends StatelessWidget {
  final InitialData data;

  const MainApp({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Movie App';
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        routerConfig: GoRouterConfig.routes,
        darkTheme: MovieAppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
