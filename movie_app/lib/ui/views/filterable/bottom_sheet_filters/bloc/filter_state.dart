part of 'filter_bloc.dart';

enum FilterStateStatus {
  initial,
  genreLoaded,
  genreLoading,
  genreError,
  selectedGenre,
  deselectedGenre,
  selectSortOption;
}

extension WhatFilterStateIs on FilterStateStatus {
  bool get isInitial => this == FilterStateStatus.initial;

  bool get isGenreLoaded => this == FilterStateStatus.genreLoaded;

  bool get isGenreLoading => this == FilterStateStatus.genreLoading;

  bool get isGenreError => this == FilterStateStatus.genreError;

  bool get isSelectedGenre => this == FilterStateStatus.selectedGenre;

  bool get isDeselectedGenre => this == FilterStateStatus.deselectedGenre;

  bool get isSelectedSortOption => this == FilterStateStatus.selectSortOption;
}

class FilterState extends Equatable {
  final List<Genre> movieGenres;
  final Set<Genre> selectedGenres;
  final String errorMessage;
  final SortOptions selectedSortOption;
  final FilterStateStatus status;

  const FilterState({
    List<Genre>? movieGenres,
    Set<Genre>? selectedGenres,
    String? errorMessage,
    SortOptions? selectedSortOption,
    required this.status,
  })  : movieGenres = movieGenres ?? const [],
        selectedGenres = selectedGenres ?? const {},
        errorMessage = errorMessage ?? "",
        selectedSortOption = selectedSortOption ?? SortOptions.popularity;

  @override
  List<Object?> get props =>
      [movieGenres, selectedGenres, errorMessage, status];

  FilterState copyWith({
    Set<Genre>? selectedGenres,
    List<Genre>? movieGenres,
    String? errorMessage,
    FilterStateStatus? status,
    SortOptions? selectedSortOption,
  }) {
    return FilterState(
      movieGenres: movieGenres ?? this.movieGenres,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
    );
  }
}
