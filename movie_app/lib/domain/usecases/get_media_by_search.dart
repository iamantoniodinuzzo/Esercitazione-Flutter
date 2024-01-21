import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetMediaBySearchUseCase
    implements UseCase<ResultState<List<Movie>>, String> {
  final MovieRepository _movieRepository;

  GetMediaBySearchUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultState<List<Movie>>> call({required String params}) {
    return _movieRepository.searchMovie(params);
  }
}
