import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class TrendingMovieState extends Equatable {
  final List<Movie> trendingMovies;
  final String? errorMessage;
  final Movie? selectedMovie;

  const TrendingMovieState({
    List<Movie>? movies,
    this.selectedMovie,
    this.errorMessage,
  }) : trendingMovies = movies ?? const [];

  @override
  List<Object?> get props => [trendingMovies, errorMessage];
}

class TrendingMoviesLoading extends TrendingMovieState {
  const TrendingMoviesLoading();
}

class TrendingMoviesLoaded extends TrendingMovieState {
  const TrendingMoviesLoaded({
    required super.movies,
  });
}

class TrendingMoviesError extends TrendingMovieState {
  const TrendingMoviesError({
    required super.errorMessage,
  });
}
