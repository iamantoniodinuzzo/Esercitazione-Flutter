import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetUpcomingMoviesUseCase
    implements UseCase<ResultState<List<Movie>>, void> {
  final MovieRepository _movieRepository;

  GetUpcomingMoviesUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultState<List<Movie>>> call({required void params}) {
    return _movieRepository.getUpcomingMovies();
  }
}
