// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logger/logger.dart';
import 'package:movie_app/data/remote/dto/collection/collection_dto.dart';
import 'package:movie_app/data/remote/dto/genre/genre_dto.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/dto/movie/movie_dto.dart';
import 'package:movie_app/data/remote/dto/production_company/production_company_dto.dart';
import 'package:movie_app/data/remote/dto/production_country/production_country_dto.dart';
import 'package:movie_app/data/remote/dto/spoken_language/spoken_language_dto.dart';
import 'package:movie_app/core/network/exception/mapper_exception.dart';
import 'package:movie_app/domain/model/collection/collection.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/model/production_company/production_company.dart';
import 'package:movie_app/domain/model/production_country/production_country.dart';
import 'package:movie_app/domain/model/spoken_language/spoken_language.dart';

class NetworkMapper {
  final Logger log;

  NetworkMapper({
    required this.log,
  });

  DOMAIN _safeMap<DOMAIN, DTO>(
    DTO dto,
    DOMAIN Function(DTO dto) mapper,
    String dtoName,
  ) {
    try {
      return mapper(dto);
    } catch (e) {
      log.w('Could not map $dtoName: ${e.toString()}');
      throw MapperException<DTO, DOMAIN>(message: e.toString());
    }
  }

  Movie toMovie(MovieDto movieDto) {
    return _safeMap<Movie, MovieDto>(
      movieDto,
      (dto) => Movie(
        adult: dto.adult,
        backdropPath: dto.backdropPath,
        id: dto.id,
        title: dto.title,
        posterPath: dto.posterPath,
        genreIds: dto.genreIds,
        popularity: dto.popularity,
        releaseDate: dto.releaseDate,
        voteAverage: dto.voteAverage,
      ),
      'MovieDto',
    );
  }

  MovieDetails toMovieDetails(MovieDetailsDto movieDetailsDto) {
    return _safeMap<MovieDetails, MovieDetailsDto>(
      movieDetailsDto,
      (dto) => MovieDetails(
        adult: dto.adult,
        backdropPath: dto.backdropPath,
        belongsToCollection: toCollection(dto.belongsToCollection),
        budget: dto.budget,
        genres: toGenreList(dto.genres),
        homepage: dto.homepage,
        id: dto.id,
        imdbId: dto.imdbId,
        originalLanguage: dto.originalLanguage,
        originalTitle: dto.originalTitle,
        overview: dto.overview,
        popularity: dto.popularity,
        posterPath: dto.posterPath,
        productionCompanies:
            toProductionCompaniesList(movieDetailsDto.productionCompanies),
        productionCountries:
            toProductionCountriesList(movieDetailsDto.productionCountries),
        releaseDate: dto.releaseDate,
        revenue: dto.revenue,
        runtime: dto.runtime,
        spokenLanguages: toSpokenLanguagesList(movieDetailsDto.spokenLanguages),
        status: dto.status,
        tagline: dto.tagline,
        title: dto.title,
        video: dto.video,
        voteAverage: dto.voteAverage,
        voteCount: dto.voteCount,
      ),
      'MovieDetailsDto',
    );
  }

  Collection? toCollection(CollectionDto? collectionDto) {
    if (collectionDto != null) {
      return _safeMap<Collection, CollectionDto>(
          collectionDto,
          (dto) => Collection(
                id: dto.id,
                name: dto.name,
                backdropPath: dto.backdropPath,
              ),
          'CollectionDto');
    }
    return null;
  }

  Genre toGenre(GenreDto genreDto) {
    return _safeMap<Genre, GenreDto>(
      genreDto,
      (dto) => Genre(id: dto.id, name: dto.name),
      'GenreDto',
    );
  }

  List<Genre> toGenreList(List<GenreDto> genresDto) {
    return genresDto.map((dto) => toGenre(dto)).toList();
  }

  List<ProductionCompany> toProductionCompaniesList(
      List<ProductionCompanyDto> companiesDto) {
    return companiesDto
        .map((dto) => _safeMap<ProductionCompany, ProductionCompanyDto>(
              dto,
              (dto) => ProductionCompany(
                  id: dto.id,
                  logoPath: dto.logoPath,
                  name: dto.name,
                  originCountry: dto.originCountry),
              'ProductionCompanyDto',
            ))
        .toList();
  }

  List<ProductionCountry> toProductionCountriesList(
      List<ProductionCountryDto> countriesDto) {
    return countriesDto
        .map((dto) => _safeMap<ProductionCountry, ProductionCountryDto>(
              dto,
              (dto) => ProductionCountry(name: dto.name),
              'ProductionCountryDto',
            ))
        .toList();
  }

  List<SpokenLanguage> toSpokenLanguagesList(
      List<SpokenLanguageDto> languagesDto) {
    return languagesDto
        .map((dto) => _safeMap<SpokenLanguage, SpokenLanguageDto>(
              dto,
              (dto) =>
                  SpokenLanguage(englishName: dto.englishName, name: dto.name),
              'SpokenLanguageDto',
            ))
        .toList();
  }

  List<Movie> toMovies(List<MovieDto> movieDtoList) {
    return movieDtoList.map((dto) => toMovie(dto)).toList();
  }
}
