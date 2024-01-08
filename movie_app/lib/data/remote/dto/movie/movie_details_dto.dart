// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/remote/dto/collection/collection_dto.dart';
import 'package:movie_app/data/remote/dto/movie/movie_dto.dart';

import '../genre/genre_dto.dart';
import '../production_company/production_company_dto.dart';
import '../production_country/production_country_dto.dart';
import '../spoken_language/spoken_language_dto.dart';

part 'movie_details_dto.g.dart';

@JsonSerializable()
class MovieDetailsDto extends MovieDto {
  @override
  final bool adult;
  @override
  @JsonKey(name: "backdrop_path")
  final String backdropPath;
  @JsonKey(name: "belongs_to_collection")
  final CollectionDto? belongsToCollection;
  final int budget;
  final List<GenreDto> genres;
  final String homepage;
  @override
  final int id;
  @JsonKey(name: "imdb_id")
  final String imdbId;
  @override
  @JsonKey(name: "original_language")
  final String originalLanguage;
  @override
  @JsonKey(name: "original_title")
  final String originalTitle;
  @override
  final String overview;
  @override
  final double popularity;
  @override
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "production_companies")
  final List<ProductionCompanyDto> productionCompanies;
  @JsonKey(name: "production_countries")
  final List<ProductionCountryDto> productionCountries;
  @override
  @JsonKey(name: "release_date")
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: "spoken_languages")
  final List<SpokenLanguageDto> spokenLanguages;
  final String status;
  final String tagline;
  @override
  final String title;
  @override
  final bool video;
  @override
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @override
  @JsonKey(name: "vote_count")
  final int voteCount;

  MovieDetailsDto({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          id: id,
          title: title,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          posterPath: posterPath,
          genreIds: genres.map((g) => g.id).toList(),
          popularity: popularity,
          releaseDate: releaseDate,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MovieDetailsDtoToJson(this);
}
