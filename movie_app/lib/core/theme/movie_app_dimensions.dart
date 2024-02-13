import 'package:flutter/material.dart';

@immutable
class MovieAppDimensions {
  const MovieAppDimensions._();

  //* Padding
  static const double basePadding = 10.0;
  static const double mediumPadding = 15.0;
  static const double largePadding = 20.0;

  //* Corner radius
  static const double baseCornerRadius = 8.0;
  static const double roundedCornerRadius = 20.0;

  //* Font sizes
  static const double hugeTitle = 36.0;
  static const double titleBig = 27.0;
  static const double titleMedium = 20.0;
  static const double titleSmall = 16.0;
  static const double body = 16.0;

  //* Poster sizes
  static const double bigPosterHeight = 140;
  static const double bigPosterWidth = 130;

  static const double smallPosterHeight = 140;
  static const double smallPosterWidth = 100;
}
