
import 'package:logger/logger.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';
import 'package:movie_app/ui/views/home/home_contract.dart';
import 'package:movie_app/util/time_window.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../../core/error/exception/server_exception_type.dart';

class HomeViewModel extends BaseViewModel<HomeVMState, HomeViewContract>
    implements HomeVMContract {
  final MovieRepository _movieRepository;
  final Logger _log;

  HomeViewModel({required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log;

  @override
  void onInitViewState() {
    vmState.trendingMovies = Loading();
    _refreshTrendingMovies();
  }

  @override
  Future<void> refreshTrendingMovies() async {
    vmState.trendingMovies = Loading();
    await _refreshTrendingMovies();
  }

  @override
  void tapOnMovie(Movie selectedMovie) {
    viewContract.goToMovieDetails(selectedMovie);
  }

  Future<void> _refreshTrendingMovies() async {
    try {
      var result = await _movieRepository.getTrendingMovies(TimeWindow.week);
      vmState.trendingMovies = Success<List<Movie>>(data: result);
      _log.i("Trending movies retrieved");
    } on ServerException catch (e) {
      _log.i('An error occurred while retrieving trending movies');
      vmState.trendingMovies = Error(message: e.message);
    }
    notifyListeners();
  }
}
