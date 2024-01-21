import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetMovieGenresUseCase implements UseCase<ResultState<List<Genre>>, void> {
  final MovieRepository _movieRepository;

  GetMovieGenresUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<ResultState<List<Genre>>> call({void params}) {
    return _movieRepository.getMovieGenres();
  }
}
