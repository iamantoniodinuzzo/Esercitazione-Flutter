import 'package:movie_app/core/network/result_state.dart';

import '../model/filter/filter.dart';
import '../model/genre/genre.dart';
import '../model/movie/movie.dart';
import '../model/movie/movie_details.dart';
import '../model/time_window.dart';

abstract class MovieRepository {

  Future<ResultState<List<Movie>>> getTrendingMovies(TimeWindow timeWindow) ;

  Future<ResultState<MovieDetails>> getMovieDetails(int movieId);

  Future<ResultState<List<Movie>>> searchMovie(String query) ;

  Future<ResultState<List<Movie>>> discoverMovieByFilter(Filter filter);

  Future<ResultState<List<Genre>>> getMovieGenres() ;
}