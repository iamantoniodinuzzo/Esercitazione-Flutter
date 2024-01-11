import 'package:flutter/material.dart';

@immutable
class AppRoutes {
  const AppRoutes._();

  //Home
  static const _homeScopeName = 'home';
  static const rootHome = AppRouteData('home', _homeScopeName, true);

  //Discover
  static const _discoverScopeName = 'discover';
  static const rootDiscover =
      AppRouteData('discover', _discoverScopeName, true);

  //Details
  static const _detailsScopeName = 'detail';
  static const details = AppRouteData('detail', _detailsScopeName, true);
}

class AppRouteData {
  final String name;
  final bool isRoot;
  final String scopeName;

  String get path => isRoot ? '/$name' : name;

  const AppRouteData(this.name, this.scopeName, [this.isRoot = false]);
}
