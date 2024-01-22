part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class GetMovieGenres extends FilterEvent {
  @override
  List<Object?> get props => [];
}

class ApplyFilter extends FilterEvent {
  final Filter filter;

  const ApplyFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class ClearFilter extends FilterEvent {
  @override
  List<Object?> get props => [];
}

class ClearGenreSelection extends FilterEvent {
  @override
  List<Object?> get props => [];
}

class SelectGenre extends FilterEvent {
  final Genre selectedGenre;

  const SelectGenre({required this.selectedGenre});

  @override
  List<Object?> get props => [selectedGenre];
}

class DeselectGenre extends FilterEvent {
  final Genre deselectedGenre;

  const DeselectGenre({required this.deselectedGenre});

  @override
  List<Object?> get props => [deselectedGenre];
}

class SelectSortOption extends FilterEvent {
  final SortOptions sortOptions;

  const SelectSortOption({required this.sortOptions});

  @override
  List<Object?> get props =>[sortOptions];
}
