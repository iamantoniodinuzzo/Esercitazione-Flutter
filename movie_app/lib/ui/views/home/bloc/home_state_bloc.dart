import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class HomeState extends Equatable {
  final List<Movie>? trendingMovies;
  final String? errorMessage;
  final Movie? selectedMovie;

  const HomeState({
    this.selectedMovie,
    this.trendingMovies,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [trendingMovies!, errorMessage];
}

class TrendingMoviesLoading extends HomeState {
  const TrendingMoviesLoading();
}

class TrendingMoviesLoaded extends HomeState {
  const TrendingMoviesLoaded({
    required super.trendingMovies,
  });
}

class TrendingMoviesError extends HomeState {
  const TrendingMoviesError({
    required super.errorMessage,
  });
}
