import '../../util/time_window.dart';
import '../models/filter/filter.dart';
import '../models/genre/genre.dart';
import '../models/movie/movie.dart';
import '../models/movie/movie_details.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow);

  Future<MovieDetails> getMovieDetails(int movieId);

  Future<List<Movie>> searchMovie(String query);

  Future<List<Movie>> discoverMovieByFilter(Filter filter);

  Future<List<Genre>> getMovieGenres();
}
