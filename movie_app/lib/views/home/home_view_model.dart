import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/util/time_window.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../domain/model/movie/movie.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepository movieRepository;
  final Logger log;

  UserInterfaceState<List<Movie>> _trendingMovies = Loading();
  UserInterfaceState<List<Movie>> get trendingMovies => _trendingMovies;

  HomeViewModel({required this.log, required this.movieRepository}) {
    fetchTrendingMovies();
  }

  /// Recupera i film in tendenza.
  /// [timeWidow] indica la finestra temporale della tendenza, di default [TimeWidow.week]
  void fetchTrendingMovies({TimeWindow timeWindow = TimeWindow.week}) async {
    try {
      var result = await movieRepository.getTrendingMovies(timeWindow);
      _trendingMovies = Success<List<Movie>>(data: result);
      notifyListeners();
    } on ServerException catch (serverException) {
      _trendingMovies = Error(message: serverException.message);
      notifyListeners();
    }
  }
}
