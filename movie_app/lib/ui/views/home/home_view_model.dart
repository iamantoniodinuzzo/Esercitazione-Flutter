// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/exception/server_exception_type.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/di/injector.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';

import '../../../domain/model/movie/movie.dart';
import '../../../domain/model/time_window.dart';
import '../../../domain/repository/movie_repository.dart';

class HomeViewModel extends BaseViewModel {
  final MovieRepository _movieRepository = getIt<MovieRepository>();
  final Logger _log = getIt<Logger>();

  ResultState<List<Movie>> _trendingMovies = Loading();

  ResultState<List<Movie>> get trendingMovies => _trendingMovies;

  /// Recupera i film in tendenza.
  /// [timeWidow] indica la finestra temporale della tendenza, di default [TimeWidow.week]
  void fetchTrendingMovies({TimeWindow timeWindow = TimeWindow.week}) async {
    try {
      var result = await _movieRepository.getTrendingMovies(timeWindow);
      _trendingMovies = Success<List<Movie>>(data: result);
      _log.d("Trending movies retrieved");
    } on ServerException catch (serverException) {
      _log.d('An error occurred while retrieving trending movies');
      _trendingMovies = Error(message: serverException.message);
    }
    notifyListeners();
  }
}
