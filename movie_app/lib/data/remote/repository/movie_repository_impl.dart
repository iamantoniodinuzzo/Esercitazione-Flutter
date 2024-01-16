// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

import '../../../domain/model/genre/genre.dart';
import '../../../domain/model/time_window.dart';

class MovieRepositoryImpl implements MovieRepository{
  final MovieService movieService;
  final NetworkMapper networkMapper;

  MovieRepositoryImpl({
    required this.movieService,
    required this.networkMapper,
  });

  @override
  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow) async {
    final trendingMovies =
        await movieService.getTrendingMovies(timeWindow);
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
