import 'package:flutter/material.dart';
import 'package:movie_app/core/routes/go_router_config.dart';
import 'package:movie_app/core/theme/movie_app_theme.dart';
import 'package:movie_app/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

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
