import '../model/filter/filter.dart';
import '../model/genre/genre.dart';
import '../model/movie/movie.dart';
import '../model/movie/movie_details.dart';
import '../model/time_window.dart';

abstract class MovieRepository {

  Future<List<Movie>> getTrendingMovies(TimeWindow timeWindow) ;

  Future<MovieDetails> getMovieDetails(int movieId);

  Future<List<Movie>> searchMovie(String query) ;

  Future<List<Movie>> discoverMovieByFilter(Filter filter);

  Future<List<Genre>> getMovieGenres() ;
}