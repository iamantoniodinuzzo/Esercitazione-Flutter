import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../data/remote/repository/movie_repository.dart';

class FilterableScreenViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  UserInterfaceState<List<Movie>> _movieDiscovered = Loading();

  UserInterfaceState<List<Movie>> get movieDiscovered => _movieDiscovered;

  FilterableScreenViewModel(
      {required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log;

  void discoverMoviesByFIlter(Filter filter) async {
    _log.d('Discover movies with this filter $filter');
    try {
      var result = await _movieRepository.discoverMovieByFilter(filter);
      _movieDiscovered = Success<List<Movie>>(data: result);
      _log.d('Movies discovered');
      notifyListeners();
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movies', error: e);
      _movieDiscovered = Error(message: e.message);
      notifyListeners();
    }
  }
}
