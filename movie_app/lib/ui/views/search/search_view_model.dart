import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/exception/server_exception_type.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/core/network/network_state.dart';

import '../../../domain/repository/movie_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  NetworkState<List<Movie>> _queryResult = Loading();
  NetworkState<List<Movie>> get queryResult => _queryResult;

  SearchViewModel({
    required MovieRepository movieRepository,
    required Logger log,
  })  : _movieRepository = movieRepository,
        _log = log;

  void searchMovie({required String query}) async {
    _log.d("Search movie with query ($query)");
    try {
      var result = await _movieRepository.searchMovie(query);
      _log.d('Emit query result');
      _queryResult = Success(data: result);
    } on ServerException catch (e) {
      _log.e('An error occurred during query', error: e);
      _queryResult = Error(message: e.message);
      notifyListeners();
    }
  }
}
