import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/filter/sort_type.dart';
import 'package:movie_app/domain/model/genre/genre.dart';

abstract class DiscoverMediaEvent {
  const DiscoverMediaEvent();
}

class GetMediaByFilter extends DiscoverMediaEvent {
  final Filter filter;

  GetMediaByFilter({required this.filter});
}

class UpdateFilterBuilder extends DiscoverMediaEvent {
  final Set<Genre> selectedGenres;
  final SortOptions selectedSortOptions;

  UpdateFilterBuilder(
      {required this.selectedGenres, required this.selectedSortOptions});
}

class FetchMovieGenres extends DiscoverMediaEvent {
  final List<Genre> movieGenres;

  FetchMovieGenres({required this.movieGenres});
}
