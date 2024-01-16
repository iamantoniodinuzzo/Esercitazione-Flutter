import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/network/exception/server_exception_type.dart';
import 'package:movie_app/di/injector.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/core/network/network_state.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';

import '../../../domain/repository/movie_repository.dart';

class SearchViewModel extends BaseViewModel {
  final MovieRepository _movieRepository = getIt<MovieRepository>();
  final Logger _log = getIt<Logger>();

  ResultState<List<Movie>> _queryResult = Loading();
  ResultState<List<Movie>> get queryResult => _queryResult;


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
