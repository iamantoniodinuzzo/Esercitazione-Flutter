import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetMediaByFilterUseCase
    implements UseCase<ResultState<List<Movie>>, Filter> {
  final MovieRepository _movieRepository;

  GetMediaByFilterUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<ResultState<List<Movie>>> call({required Filter params}) {
    return _movieRepository.discoverMovieByFilter(params);
  }
}
