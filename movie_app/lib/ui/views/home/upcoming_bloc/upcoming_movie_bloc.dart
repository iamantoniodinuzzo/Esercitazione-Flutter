import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_app/ui/views/home/upcoming_bloc/upcoming_movie_event.dart';
import 'package:movie_app/ui/views/home/upcoming_bloc/upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final GetUpcomingMoviesUseCase _getUpcomingMovies;

  UpcomingMovieBloc(this._getUpcomingMovies)
      : super(
          const UpcomingMoviesLoading(), //Lo stato di default è quello di caricamento
        ) {
    //COme mi devo comportare con un evento rispondendo con uno stato
    on<GetUpcomingMovies>(_onGetTrendingMovies);
  }

  void _onGetTrendingMovies(
      GetUpcomingMovies event, Emitter<UpcomingMovieState> emit) async {
    final trendingMovieState = await _getUpcomingMovies(params: Void);

    switch (trendingMovieState) {
      case Success<List<Movie>>(data: var data):
        if (data.isNotEmpty) emit(UpcomingMoviesLoaded(movies: data));
      case Error<List<Movie>>(message: var errorMessage):
        emit(UpcomingMoviesError(errorMessage: errorMessage));
      case Loading<List<Movie>>():
        emit(const UpcomingMoviesLoading());
    }
  }
}
