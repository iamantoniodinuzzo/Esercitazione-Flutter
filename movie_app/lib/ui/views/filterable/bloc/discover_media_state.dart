import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class FilteredMediaState {
  final Filter? appliedFilter;
  final List<Movie>? filteredMedia;
  final String? errorMessage;
  final Set<Genre>? selectedGenres;
  final List<Genre>? movieGenres;

  FilteredMediaState(
      {this.appliedFilter,
      this.filteredMedia,
      this.errorMessage,
      this.selectedGenres,
      this.movieGenres});
}

class FilteredMediaLoaded extends FilteredMediaState {
  FilteredMediaLoaded({super.filteredMedia, super.appliedFilter});
}

class FilteredMediaError extends FilteredMediaState {
  FilteredMediaError({super.errorMessage});
}

class FilteredMediaLoading extends FilteredMediaState {}

class MovieGenresLoaded extends FilteredMediaState {
  MovieGenresLoaded({super.movieGenres});
}

class MovieGenresError extends FilteredMediaState {
  MovieGenresError({super.errorMessage});
}

class MovieGenresLoading extends FilteredMediaState {}
