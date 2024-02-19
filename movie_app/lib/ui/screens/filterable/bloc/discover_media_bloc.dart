import 'package:bloc/bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_media_by_filter.dart';
import 'package:movie_app/ui/screens/filterable/bloc/discover_media_event.dart';
import 'package:movie_app/ui/screens/filterable/bloc/discover_media_state.dart';

class DiscoverMediaBloc extends Bloc<DiscoverMediaEvent, DiscoverMediaState> {
  final GetMediaByFilterUseCase _getMediaByFilterUseCase;

  DiscoverMediaBloc(this._getMediaByFilterUseCase)
      : super(
          DiscoverMediaState(
            status: DiscoverMediaStateStatus.initial,
          ),
        ) {
    on<GetMediaByFilter>(_onMediaDiscovered);
  }

  void _onMediaDiscovered(
      GetMediaByFilter event, Emitter<DiscoverMediaState> emit) async {

    emit(
      state.copyWith(status: DiscoverMediaStateStatus.mediaLoading),
    );

    final filteredMovies = await _getMediaByFilterUseCase(params: event.filter);
    switch (filteredMovies) {
      case Success<List<Movie>>(data: var movies):
        if (movies.isNotEmpty) {
          emit(
            state.copyWith(
              filteredMedia: movies,
              status: DiscoverMediaStateStatus.mediaLoaded,
            ),
          );
        }
      case Error<List<Movie>>(message: var errorMessage):
        emit(
          state.copyWith(
            errorMessage: errorMessage,
            status: DiscoverMediaStateStatus.mediaError,
          ),
        );
      case Loading<List<Movie>>():
        emit(
          state.copyWith(status: DiscoverMediaStateStatus.mediaLoading),
        );
    }
  }
}
