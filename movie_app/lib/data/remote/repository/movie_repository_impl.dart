// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/data/remote/mapper/genre_mapper.dart';
import 'package:movie_app/data/remote/mapper/movie_mapper.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

import '../../../domain/model/genre/genre.dart';
import '../../../domain/model/time_window.dart';

class MovieRepositoryImpl implements MovieRepository{
  final MovieService _movieService;

  MovieRepositoryImpl({
    required MovieService movieService,
  }) : _movieService = movieService;

  @override
  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow) async {
    final trendingMovies =
        await _movieService.getTrendingMovies(timeWindow);
    final mappedResult = trendingMovies.results.mapToDomain().toList();
    return mappedResult;
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final movieDetails = await _movieService.getMovieDetails(movieId);
    final MovieDetails mappedResult = movieDetails.mapToDomain() as MovieDetails;
    return mappedResult;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    final baseResponse = await _movieService.searchMovie(query);
    final mappedResult = baseResponse.results.mapToDomain().toList();
    return mappedResult;
  }

  @override
  Future<List<Movie>> discoverMovieByFilter(Filter filter) async {
    final baseResponse = await _movieService.discoverMovieByFilter(filter);
    final mappedResult = baseResponse.results.mapToDomain().toList();
    return mappedResult;
  }

  @override
  Future<List<Genre>> getMovieGenres() async {
    final baseResponse = await _movieService.getMovieGenres();
    final mappedResult = baseResponse.genres.mapToDomain().toList();
    return mappedResult;
  }
}
