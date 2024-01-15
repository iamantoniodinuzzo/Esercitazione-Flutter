import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/data/repository/movie_repository_impl.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/util/user_interface_state.dart';

class SearchViewModel extends ChangeNotifier {
  final MovieRepositoryImpl _movieRepository;
  final Logger _log;

  UserInterfaceState<List<Movie>> _queryResult = Loading();
  UserInterfaceState<List<Movie>> get queryResult => _queryResult;

  SearchViewModel({
    required MovieRepositoryImpl movieRepository,
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
