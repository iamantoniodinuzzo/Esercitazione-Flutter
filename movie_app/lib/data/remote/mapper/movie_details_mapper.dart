import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/mapper/collection_mapper.dart';
import 'package:movie_app/data/remote/mapper/genre_mapper.dart';
import 'package:movie_app/data/remote/mapper/production_companies_mapper.dart';
import 'package:movie_app/data/remote/mapper/production_countries_mapper.dart';
import 'package:movie_app/data/remote/mapper/spoken_language_mapper.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';

extension MovieDetailsMapper on MovieDetailsDto {
  MovieDetails mapToDomain() {
    return MovieDetails(
      adult: adult,
      backdropPath: backdropPath,
      belongsToCollection: belongsToCollection.mapToDomain(),
      budget: budget,
      genres: genres.mapToDomain().toList(),
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies.mapToDomain().toList(),
      productionCountries: productionCountries.mapToDomain().toList(),
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      spokenLanguages: spokenLanguages.mapToDomain().toList(),
      status: status,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
