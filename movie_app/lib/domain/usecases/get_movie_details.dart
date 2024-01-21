import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class GetMovieDetailsUseCase implements UseCase<ResultState<MovieDetails>, int> {
  final MovieRepository _movieRepository;

  GetMovieDetailsUseCase({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultState<MovieDetails>> call({required int params}) {
    return _movieRepository.getMovieDetails(params);
  }
}
