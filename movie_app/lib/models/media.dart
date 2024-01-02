import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Media {
  final String title;
  final String backdropPath;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  Media({
    required this.title,
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'backdropPath': backdropPath,
      'originalTitle': originalTitle,
      'overview': overview,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }

  factory Media.fromMap(Map<String, dynamic> json) {
    return Media(
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      voteAverage: json['vote_average'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source) as Map<String, dynamic>);
}
