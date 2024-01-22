import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

sealed class SearchMediaState extends Equatable {
  final List<Movie> result;
  final String errorMessage;

  const SearchMediaState({List<Movie>? movieResult, String? errorMessage})
      : result = movieResult ?? const [],
        errorMessage = errorMessage ?? "";

  @override
  List<Object?> get props => [result, errorMessage];
}
class SearchMediaInitial extends SearchMediaState{
  const SearchMediaInitial();
}
class SearchMediaLoaded extends SearchMediaState {
  const SearchMediaLoaded({super.movieResult});
}

class SearchMediaError extends SearchMediaState {
  const SearchMediaError({super.errorMessage});
}

class SearchMediaLoading extends SearchMediaState {
  const SearchMediaLoading();
}
