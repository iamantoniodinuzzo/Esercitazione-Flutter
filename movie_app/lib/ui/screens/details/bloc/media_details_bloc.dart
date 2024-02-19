import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/usecases/get_movie_details.dart';
import 'package:movie_app/ui/screens/details/bloc/media_details_event.dart';
import 'package:movie_app/ui/screens/details/bloc/media_details_state.dart';

class MediaDetailsBloc extends Bloc<MediaDetailsEvent, MediaDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;

  MediaDetailsBloc(this._getMovieDetailsUseCase)
      : super(
          const MediaDetailsLoading(),
        ) {
    on<GetMovieDetails>(onGetMediaDetails);
  }

  void onGetMediaDetails(
      GetMovieDetails event, Emitter<MediaDetailsState> emit) async {
    final movieDetails =
        await _getMovieDetailsUseCase(params: event.selectedMovie.id);
    switch (movieDetails) {
      case Success<MovieDetails>():
        emit(
          MediaDetailsLoaded(movieDetails: movieDetails.data),
        );
      case Error<MovieDetails>():
        emit(MediaDetailsError(errorMessage: movieDetails.message));
      case Loading<MovieDetails>():
        emit(const MediaDetailsLoading());
    }
  }
}
