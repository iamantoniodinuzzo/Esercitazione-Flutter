import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/movie_app_color_scheme.dart';
import 'package:movie_app/core/theme/movie_app_colors.dart';

class MovieAppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    primaryColor: MovieAppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MovieAppColors.primaryVariant,
    cardColor: MovieAppColors.primaryVariant,
    colorScheme: MovieAppColorScheme.colorScheme,
  );
}
