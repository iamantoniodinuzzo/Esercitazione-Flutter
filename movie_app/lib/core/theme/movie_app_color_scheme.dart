import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/movie_app_colors.dart';

@immutable
class MovieAppColorScheme {
  const MovieAppColorScheme._();

  static const colorScheme = ColorScheme(
    background: MovieAppColors.primary,
    brightness: Brightness.dark,
    primary: MovieAppColors.primary,
    secondary: MovieAppColors.secondary,
    onPrimary: MovieAppColors.onPrimary,
    onSecondary: MovieAppColors.onSecondary,
    onBackground: MovieAppColors.whiteNew,
    error: Colors.red,
    onError: MovieAppColors.whiteNew,
    surface: MovieAppColors.primaryVariant,
    onSurface: MovieAppColors.onPrimary,
  );
}
