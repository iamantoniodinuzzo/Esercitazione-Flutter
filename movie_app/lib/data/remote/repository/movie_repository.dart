// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/util/time_window.dart';

import '../../../domain/model/genre/genre.dart';

class MovieRepository {
  final MovieService movieService;
  final NetworkMapper networkMapper;

  MovieRepository({
    required this.movieService,
    required this.networkMapper,
  });

  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow) async {
    final trendingMovies =
        await movieService.getTrendingMovies(timeWindow.name);
    final mappedResult = networkMapper.toMovies(trendingMovies.results);
    return mappedResult;
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final movieDetails = await movieService.getMovieDetails(movieId);
    final mappedResult = networkMapper.toMovieDetails(movieDetails);
    return mappedResult;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final baseResponse = await movieService.searchMovie(query);
    final mappedResult = networkMapper.toMovies(baseResponse.results);
    return mappedResult;
  }

  Future<List<Movie>> discoverMovieByFilter(Filter filter) async {
    final baseResponse = await movieService.discoverMovieByFilter(filter);
    final mappedResult = networkMapper.toMovies(baseResponse.results);
    return mappedResult;
  }

  Future<List<Genre>> getMovieGenres() async {
    final baseResponse = await movieService.getMovieGenres();
    final mappedResult = networkMapper.toGenreList(baseResponse.genres);
    return mappedResult;
  }
}
