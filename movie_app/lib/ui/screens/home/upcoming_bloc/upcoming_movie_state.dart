import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class UpcomingMovieState extends Equatable {
  final List<Movie> upcomingMovies;
  final String? errorMessage;
  final Movie? selectedMovie;

  const UpcomingMovieState({
    List<Movie>? movies,
    this.selectedMovie,
    this.errorMessage,
  }) : upcomingMovies = movies ?? const [];

  @override
  List<Object?> get props => [upcomingMovies, errorMessage];
}

class UpcomingMoviesLoading extends UpcomingMovieState {
  const UpcomingMoviesLoading();
}

class UpcomingMoviesLoaded extends UpcomingMovieState {
  const UpcomingMoviesLoaded({
    required super.movies,
  });
}

class UpcomingMoviesError extends UpcomingMovieState {
  const UpcomingMoviesError({
    required super.errorMessage,
  });
}
