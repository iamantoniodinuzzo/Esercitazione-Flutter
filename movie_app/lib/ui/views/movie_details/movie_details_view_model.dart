import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/domain/models/movie/movie_details.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';
import 'package:movie_app/ui/views/movie_details/movie_details_contract.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../../domain/repository/movie_repository.dart';

class MovieDetailsViewModel
    extends BaseViewModel<MovieDetailsVMState, MovieDetailsViewContract>
    implements MovieDetailsVMContract {
  final MovieRepository _movieRepository;
  final Logger _log;

  MovieDetailsViewModel(
      {required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log;

  @override
  void onInitViewState() {
    vmState.movieDetails = Loading();
  }

  void _getMovieDetails(int movieId) async {
    _log.d('Search movie details wth id ($movieId)');
    try {
      var result = await _movieRepository.getMovieDetails(movieId);
      vmState.movieDetails = Success<MovieDetails>(data: result);
      _log.d('Movie details retrieved');
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movie details', error: e);
      vmState.movieDetails = Error(message: e.message);
    }
    notifyListeners();
  }

  @override
  void getMovieDetails(int movieId) {
    _getMovieDetails(movieId);
  }
}
