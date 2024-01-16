// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/exception/server_exception_type.dart';
import 'package:movie_app/core/network/network_state.dart';

import '../../../domain/model/movie/movie.dart';
import '../../../domain/model/time_window.dart';
import '../../../domain/repository/movie_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  NetworkState<List<Movie>> _trendingMovies = Loading();
  NetworkState<List<Movie>> get trendingMovies => _trendingMovies;

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
