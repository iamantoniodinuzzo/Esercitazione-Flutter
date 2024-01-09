// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/util/time_window.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../domain/model/movie/movie.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  UserInterfaceState<List<Movie>> _trendingMovies = Loading();
  UserInterfaceState<List<Movie>> get trendingMovies => _trendingMovies;

  HomeViewModel({
    required MovieRepository movieRepository,
    required Logger log,
  })  : _movieRepository = movieRepository,
        _log = log {
    fetchTrendingMovies();
  }

  /// Recupera i film in tendenza.
  /// [timeWidow] indica la finestra temporale della tendenza, di default [TimeWidow.week]
  void fetchTrendingMovies({TimeWindow timeWindow = TimeWindow.week}) async {
    try {
      var result = await _movieRepository.getTrendingMovies(timeWindow);
      _trendingMovies = Success<List<Movie>>(data: result);
      _log.d("Trending movies retrieved");
      notifyListeners();
    } on ServerException catch (serverException) {
      _log.d('An error occurred while retrieving trending movies');
      _trendingMovies = Error(message: serverException.message);
      notifyListeners();
    }
  }
}
