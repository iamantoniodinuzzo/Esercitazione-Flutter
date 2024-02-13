import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/ui/views/home/trending_bloc/trending_movie_event.dart';
import 'package:movie_app/ui/views/home/trending_bloc/trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final GetTrendingMoviesUseCase _getTrendingMovies;

  TrendingMovieBloc(this._getTrendingMovies)
      : super(
          const TrendingMoviesLoading(), //Lo stato di default è quello di caricamento
        ) {
    //COme mi devo comportare con un evento rispondendo con uno stato
    on<GetTrendingMovies>(_onGetTrendingMovies);
  }

  void _onGetTrendingMovies(
      GetTrendingMovies event, Emitter<TrendingMovieState> emit) async {
    final trendingMovieState = await _getTrendingMovies();

    switch (trendingMovieState) {
      case Success<List<Movie>>(data: var data):
        if (data.isNotEmpty) emit(TrendingMoviesLoaded(movies: data));
      case Error<List<Movie>>(message: var errorMessage):
        emit(TrendingMoviesError(errorMessage: errorMessage));
      case Loading<List<Movie>>():
        emit(const TrendingMoviesLoading());
    }
  }
}
