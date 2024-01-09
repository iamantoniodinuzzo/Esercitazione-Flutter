import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/views/details/detail_screen.dart';
import 'package:movie_app/views/home/home_screen.dart';
import 'package:movie_app/views/routes/app_routes.dart';

import '../../domain/model/movie/movie.dart';

@immutable
class GoRouterConfig {
  const GoRouterConfig._();

  static final routes = GoRouter(
    initialLocation: AppRoutes.rootHome.path,
    routes: [
      GoRoute(
        path: AppRoutes.rootHome.path,
        name: AppRoutes.rootHome.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.details.path,
        name: AppRoutes.details.name,
        builder: (context, state) {
          final Movie? selectedMedia = state.extra as Movie?;
          if (selectedMedia == null) {
            return const Scaffold();
          } else {
            return DetailScreen(
              selectedMedia: selectedMedia,
            );
          }
        },
      ),
    ],
  );
}