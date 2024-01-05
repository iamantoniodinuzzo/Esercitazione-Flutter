// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movie_app/util/media_type.dart';

class Movie {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String posterPath;
  final MediaType mediaType;
  final List<int> genreIds;
  final double popularity;
  final DateTime releaseDate;
  final double voteAverage;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
  }) : mediaType = MediaType.movie;
}



