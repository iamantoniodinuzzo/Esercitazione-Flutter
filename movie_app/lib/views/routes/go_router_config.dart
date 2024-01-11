import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/views/details/detail_screen.dart';
import 'package:movie_app/views/discover/discover_screen.dart';
import 'package:movie_app/views/filterable/filterable_screen.dart';
import 'package:movie_app/views/home/home_screen.dart';
import 'package:movie_app/views/routes/app_routes.dart';
import 'package:movie_app/views/routes/scaffold_with_nav_bar.dart';

import '../../domain/model/movie/movie.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

@immutable
class GoRouterConfig {
  const GoRouterConfig._();

  static final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.rootHome.path,
    routes: [
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
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRoutes.filterable.path,
        name: AppRoutes.filterable.name,
        builder: (context, state) => const FilterableScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.rootHome.path,
                name: AppRoutes.rootHome.name,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.rootDiscover.path,
                name: AppRoutes.rootDiscover.name,
                builder: (context, state) => const DiscoverScreen(),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
