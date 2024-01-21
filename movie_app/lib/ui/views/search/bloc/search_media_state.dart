import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class SearchMediaState extends Equatable {
  final List<Movie>? searchMovieResult;
  final String? errorMessage;

  const SearchMediaState({this.searchMovieResult, this.errorMessage});
  @override
  List<Object?> get props => [searchMovieResult!, errorMessage!];
}

class SearchMediaLoaded extends SearchMediaState {
  const SearchMediaLoaded({super.searchMovieResult});
}

class SearchMediaError extends SearchMediaState {
  const SearchMediaError({super.errorMessage});
}

class SearchMediaLoading extends SearchMediaState {
  const SearchMediaLoading();
}
