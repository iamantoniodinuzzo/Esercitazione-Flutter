import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

enum DiscoverMediaStateStatus {
  initial,
  mediaLoaded,
  mediaLoading,
  mediaError;
}

class DiscoverMediaState extends Equatable {
  final Filter appliedFilter;
  final List<Movie> filteredMedia;
  final String errorMessage;
  final DiscoverMediaStateStatus status;

  DiscoverMediaState(
      {Filter? appliedFilter,
      List<Movie>? filteredMedia,
      String? errorMessage,
      required this.status})
      : appliedFilter = appliedFilter ?? FilterBuilder().build(),
        filteredMedia = filteredMedia ?? const [],
        errorMessage = errorMessage ?? "";

  @override
  List<Object?> get props =>
      [appliedFilter, filteredMedia, errorMessage, status];

  DiscoverMediaState copyWith(
      {Filter? appliedFilter,
      List<Movie>? filteredMedia,
      String? errorMessage,
      DiscoverMediaStateStatus? status}) {
    return DiscoverMediaState(
      status: status ?? this.status,
      appliedFilter: appliedFilter ?? this.appliedFilter,
      filteredMedia: filteredMedia ?? this.filteredMedia,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
