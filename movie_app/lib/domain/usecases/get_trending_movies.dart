import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/time_window.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetTrendingMoviesUseCase
    implements UseCase<ResultState<List<Movie>>, TimeWindow> {
  final MovieRepository _movieRepository;

  GetTrendingMoviesUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultState<List<Movie>>> call({TimeWindow params = TimeWindow.week}) {
    return _movieRepository.getTrendingMovies(params);
  }
}
