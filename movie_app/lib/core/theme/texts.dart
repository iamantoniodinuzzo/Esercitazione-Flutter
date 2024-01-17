import 'package:flutter/cupertino.dart';

import 'colors.dart';

@immutable
class MovieAppTextStyle {
  const MovieAppTextStyle._();

  ///
  /// Primary Font Styles (Open Sans)
  ///
  static const primaryH1Bold = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w700,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 37.0);

  static const primaryH1Regular = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w300,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 37.0);

  static const primaryPRegular = TextStyle(
      color: MovieAppColors.onPrimary,
      fontWeight: FontWeight.w300,
      fontFamily: 'Open Sans',
      fontStyle: FontStyle.normal,
      fontSize: 16.0);

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
