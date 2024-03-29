import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/colors.dart';

class MovieAppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    primaryColor: MovieAppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MovieAppColors.primaryVariant,
    cardColor: MovieAppColors.primaryVariant,
    colorScheme: const ColorScheme(
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
    ),
  );
}
