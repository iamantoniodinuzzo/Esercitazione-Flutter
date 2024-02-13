import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/theme/movie_app_dimensions.dart';

import 'movie_app_colors.dart';

@immutable
class MovieAppTextStyle {
  const MovieAppTextStyle._();

  ///
  /// Primary Font Styles (Open Sans)
  ///
  static const hugeTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Open Sans',
    fontStyle: FontStyle.normal,
    fontSize: MovieAppDimensions.titleBig,
  );

  static const mediumTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Open Sans',
    fontStyle: FontStyle.normal,
    fontSize: MovieAppDimensions.titleBig,
  );

  static const primaryH1Regular = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.normal,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 37.0);

  static const body = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: 'Open Sans',
    fontStyle: FontStyle.normal,
    fontSize: MovieAppDimensions.body,
  );

  static const primaryPBold = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  ///
  /// Secondary Font Styles (Roboto)
  ///
  static const secondaryH1Bold = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 37.0);

  static const secondaryH1Regular = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w300,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 37.0);

  static const secondaryPRegular = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w300,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

  static const secondaryPBold = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontSize: 16.0);
}
