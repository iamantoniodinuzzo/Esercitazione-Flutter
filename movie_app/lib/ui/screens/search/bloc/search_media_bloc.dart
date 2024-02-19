import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_media_by_search.dart';
import 'package:movie_app/ui/screens/search/bloc/search_media_event.dart';
import 'package:movie_app/ui/screens/search/bloc/search_media_state.dart';

class SearchMediaBloc extends Bloc<SearchMediaEvent, SearchMediaState> {
  final GetMediaBySearchUseCase _getMediaBySearchUseCase;

  SearchMediaBloc(this._getMediaBySearchUseCase)
      : super(
          const SearchMediaInitial(),
        ) {
    on<GetSearchMedia>(onSearchMedia);
  }

  void onSearchMedia(
      GetSearchMedia event, Emitter<SearchMediaState> emit) async {
    final searchResult = await _getMediaBySearchUseCase(params: event.query);
    switch (searchResult) {
      case Success<List<Movie>>(data: var searchResult):
        if (searchResult.isNotEmpty) {
          emit(SearchMediaLoaded(movieResult: searchResult));
        }
      case Error<List<Movie>>(message: var message):
        emit(SearchMediaError(errorMessage: message));
      case Loading<List<Movie>>():
        emit(const SearchMediaError());
    }
  }
}
