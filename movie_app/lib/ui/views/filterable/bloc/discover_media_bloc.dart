import 'package:bloc/bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_media_by_filter.dart';
import 'package:movie_app/domain/usecases/get_movie_genres.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_event.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_state.dart';

class DiscoverMediaBloc extends Bloc<DiscoverMediaEvent, FilteredMediaState> {
  final GetMediaByFilterUseCase _getMediaByFilterUseCase;
  final GetMovieGenresUseCase _getMovieGenresUseCase;

  DiscoverMediaBloc(this._getMediaByFilterUseCase, this._getMovieGenresUseCase)
      : super(FilteredMediaLoaded(appliedFilter: FilterBuilder().build())) {
    on<GetMediaByFilter>(onMediaDiscovered);
    on<FetchMovieGenres>(onFetchMovieGenres);
    //TODO: Inserire l'aggiornamento dei filtri
  }

  void onMediaDiscovered(
      GetMediaByFilter event, Emitter<FilteredMediaState> emit) async {
    final filteredMovies = await _getMediaByFilterUseCase(params: event.filter);
    switch (filteredMovies) {
      case Success<List<Movie>>(data: var movies):
        if (movies.isNotEmpty) {
          emit(
            FilteredMediaLoaded(filteredMedia: movies),
          );
        }
      case Error<List<Movie>>(message: var errorMessage):
        emit(
          FilteredMediaError(errorMessage: errorMessage),
        );
      case Loading<List<Movie>>():
        emit(
          FilteredMediaLoading(),
        );
    }
  }

  void onFetchMovieGenres(
      FetchMovieGenres event, Emitter<FilteredMediaState> emit) async {
    final movieGenresStatus = await _getMovieGenresUseCase();
    switch (movieGenresStatus) {
      case Success<List<Genre>>(data: var genres):
        if (genres.isNotEmpty) {
          emit(MovieGenresLoaded(movieGenres: genres));
        }
      case Error<List<Genre>>(message: var errorMessage):
        emit(MovieGenresError(errorMessage: errorMessage));
      case Loading<List<Genre>>():
        emit(MovieGenresLoading());
    }
  }
}
