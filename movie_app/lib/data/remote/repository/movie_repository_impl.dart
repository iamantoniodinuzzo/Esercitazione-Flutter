// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/core/network/exception/api_exception.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/mapper/genre_mapper.dart';
import 'package:movie_app/data/remote/mapper/movie_mapper.dart';
import 'package:movie_app/data/remote/mapper/movie_details_mapper.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

import '../../../domain/model/genre/genre.dart';
import '../../../domain/model/time_window.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  MovieRepositoryImpl({
    required MovieService movieService,
  }) : _movieService = movieService;

  @override
  Future<ResultState<List<Movie>>> getTrendingMovies(
      TimeWindow timeWindow) async {
    try {
      final trendingMovies = await _movieService.getTrendingMovies(timeWindow);
      final mappedResult = trendingMovies.results.mapToDomain().toList();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }

  @override
  Future<ResultState<MovieDetails>> getMovieDetails(int movieId) async {
    try {
      final MovieDetailsDto movieDetails =
          await _movieService.getMovieDetails(movieId);
      final MovieDetails mappedResult = movieDetails.mapToDomain();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }

  @override
  Future<ResultState<List<Movie>>> searchMovie(String query) async {
    try {
      final baseResponse = await _movieService.searchMovie(query);
      final mappedResult = baseResponse.results.mapToDomain().toList();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }

  @override
  Future<ResultState<List<Movie>>> discoverMovieByFilter(Filter filter) async {
    try {
      final baseResponse = await _movieService.discoverMovieByFilter(filter);
      final mappedResult = baseResponse.results.mapToDomain().toList();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }

  @override
  Future<ResultState<List<Genre>>> getMovieGenres() async {
    try {
      final baseResponse = await _movieService.getMovieGenres();
      final mappedResult = baseResponse.genres.mapToDomain().toList();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }

  @override
  Future<ResultState<List<Movie>>> getUpcomingMovies() async {
    try {
      final trendingMovies = await _movieService.getUpcomingMovies();
      final mappedResult = trendingMovies.results.mapToDomain().toList();
      return Success(data: mappedResult);
    } on ApiException catch (e) {
      return Error(message: e.message);
    }
  }
}
