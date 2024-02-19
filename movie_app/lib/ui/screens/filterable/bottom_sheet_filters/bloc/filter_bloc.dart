import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/filter/sort_type.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/domain/usecases/get_movie_genres.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final GetMovieGenresUseCase _getMovieGenresUseCase;

  FilterBloc(this._getMovieGenresUseCase) : super(const FilterState(status: FilterStateStatus.initial)) {
    on<GetMovieGenres>(_onGetMovieGenres);
    on<SelectGenre>(_onSelectGenre);
    on<DeselectGenre>(_onDeselectGenre);
    on<SelectSortOption>(_onSelectSortOption);
  }

  void _onGetMovieGenres(
      GetMovieGenres event, Emitter<FilterState> emit) async {
    emit(
      state.copyWith(status: FilterStateStatus.genreLoading),
    );
    final movieGenresState = await _getMovieGenresUseCase();
    switch (movieGenresState) {
      case Success<List<Genre>>(data: var movieGenres):
        emit(
          state.copyWith(
              status: FilterStateStatus.genreLoaded, movieGenres: movieGenres),
        );
      case Error<List<Genre>>(message: var errorMessage):
        emit(
          state.copyWith(
            status: FilterStateStatus.genreError,
            errorMessage: errorMessage,
          ),
        );
      case Loading<List<Genre>>():
        emit(
          state.copyWith(status: FilterStateStatus.genreLoading),
        );
    }
  }

  void _onSelectGenre(SelectGenre event, Emitter<FilterState> emit) {
    var updateGenreSelection = state.selectedGenres;
    updateGenreSelection.add(event.selectedGenre);
    emit(
      state.copyWith(
        status: FilterStateStatus.selectedGenre,
        selectedGenres: updateGenreSelection,
      ),
    );
  }

  void _onDeselectGenre(DeselectGenre event, Emitter<FilterState> emit) {
    var updateGenreSelection = state.selectedGenres;
    updateGenreSelection.remove(event.deselectedGenre);
    emit(
      state.copyWith(
        status: FilterStateStatus.deselectedGenre,
        selectedGenres: updateGenreSelection,
      ),
    );
  }

  void _onSelectSortOption(SelectSortOption event, Emitter<FilterState> emit) {
    var selectSortOption = event.sortOptions;
    emit(
      state.copyWith(
        status: FilterStateStatus.selectSortOption,
        selectedSortOption: selectSortOption,
      ),
    );
  }
}
