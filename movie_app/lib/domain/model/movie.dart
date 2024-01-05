// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  }) : mediaType = MediaType.MOVIE;
}

enum MediaType {
  MOVIE;
}

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage {
  EN,
  JA;
}

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
