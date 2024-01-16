// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/theme.dart';
import 'package:movie_app/core/routes/go_router_config.dart';
import 'package:movie_app/di/injector.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/ui/views/home/home_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocatorInitialization();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Movie App';
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      routerConfig: GoRouterConfig.routes,
      darkTheme: MovieAppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
