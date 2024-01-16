// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:movie_app/core/locators/locator.dart';
import 'package:movie_app/ui/theme/theme.dart';
import 'package:movie_app/ui/routes/go_router_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Load project configuration
  await serviceLocatorInitialization();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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

