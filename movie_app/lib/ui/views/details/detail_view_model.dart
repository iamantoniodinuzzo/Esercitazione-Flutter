import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/exception/server_exception_type.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/core/network/network_state.dart';

import '../../../domain/repository/movie_repository.dart';

class DetailViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  NetworkState<MovieDetails> _movieDetails = Loading();

  NetworkState<MovieDetails> get movieDetails => _movieDetails;

  DetailViewModel(
      {required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log;

  void getMovieDetails(int movieId) async {
    _log.d('Search movie details wth id ($movieId)');
    try {
      var result = await _movieRepository.getMovieDetails(movieId);
      _movieDetails = Success<MovieDetails>(data: result);
      _log.d('Movie details retrieved');
      notifyListeners();
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movie details', error: e);
      _movieDetails = Error(message: e.message);
      notifyListeners();
    }
  }
}
