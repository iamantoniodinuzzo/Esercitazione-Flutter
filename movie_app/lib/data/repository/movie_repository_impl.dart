// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/modules/services/movie_service.dart';
import 'package:movie_app/domain/models/filter/filter.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/domain/models/movie/movie_details.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/util/time_window.dart';

import '../../domain/models/genre/genre.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService movieService;
  final NetworkMapper networkMapper;

  MovieRepositoryImpl({
    required this.movieService,
    required this.networkMapper,
  });

  @override
  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow) async {
    final trendingMovies = await movieService.getTrendingMovies(timeWindow);
    final mappedResult = networkMapper.toMovies(trendingMovies.results);
    return mappedResult;
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final movieDetails = await movieService.getMovieDetails(movieId);
    final mappedResult = networkMapper.toMovieDetails(movieDetails);
    return mappedResult;
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    final baseResponse = await movieService.searchMovie(query);
    final mappedResult = networkMapper.toMovies(baseResponse.results);
    return mappedResult;
  }

  @override
  Future<List<Movie>> discoverMovieByFilter(Filter filter) async {
    final baseResponse = await movieService.discoverMovieByFilter(filter);
    final mappedResult = networkMapper.toMovies(baseResponse.results);
    return mappedResult;
  }

  @override
  Future<List<Genre>> getMovieGenres() async {
    final baseResponse = await movieService.getMovieGenres();
    final mappedResult = networkMapper.toGenreList(baseResponse.genres);
    return mappedResult;
  }
}
