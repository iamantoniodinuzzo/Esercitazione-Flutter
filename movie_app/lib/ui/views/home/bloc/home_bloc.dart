import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/ui/views/home/bloc/home_event_bloc.dart';
import 'package:movie_app/ui/views/home/bloc/home_state_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingMoviesUseCase _getTrendingMovies;

  HomeBloc(this._getTrendingMovies)
      : super(
          const TrendingMoviesLoading(),
        ) {
    on<GetTrendingMovies>(onGetTrendingMovies);
  }

  void onGetTrendingMovies(
      GetTrendingMovies event, Emitter<HomeState> emit) async {
    final dataState = await _getTrendingMovies();
    switch (dataState) {
      case Success<List<Movie>>(data: var data):
        if (data.isNotEmpty) emit(TrendingMoviesLoaded(trendingMovies: data));
      case Error<List<Movie>>(message: var errorMessage):
        emit(TrendingMoviesError(errorMessage: errorMessage));
      case Loading<List<Movie>>():
        emit(const TrendingMoviesLoading());
    }
  }
}
