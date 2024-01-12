import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../data/remote/repository/movie_repository.dart';
import '../../domain/model/filter/sort_type.dart';
import '../../domain/model/genre/genre.dart';

class FilterableScreenViewModel extends ChangeNotifier {
  final MovieRepository _movieRepository;
  final Logger _log;

  FilterBuilder _filter = FilterBuilder();

  //* Film filtrati
  UserInterfaceState<List<Movie>> _movieDiscovered = Loading();
  UserInterfaceState<List<Movie>> get movieDiscovered => _movieDiscovered;
  //* Generi dei film
  UserInterfaceState<List<Genre>> _movieGenres = Loading();
  UserInterfaceState<List<Genre>> get movieGenres => _movieGenres;
  //* Sort by selezionato
  SortOptions _selectedSortOption = SortOptions.popularity;
  SortOptions get selectedSortOption => _selectedSortOption;
  //* Generi selezionati
  Set<Genre> _selectedGenres = <Genre>{};
  Set<Genre> get selectedGenres => _selectedGenres;

  FilterableScreenViewModel(
      {required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log {
    discoverMoviesByFIlter(_filter.build());
    _getMovieGenres();
  }

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

  void _getMovieGenres() async {
    _log.d('Retrieve movie\'s genres');
    try {
      var result = await _movieRepository.getMovieGenres();
      _movieGenres = Success<List<Genre>>(data: result);
      _log.d('Movie genres retrieved');
      notifyListeners();
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movie genres', error: e);
      _movieGenres = Error(message: e.message);
      notifyListeners();
    }
  }

  void selectSortBy(SortOptions sortType) {
    _selectedSortOption = sortType;
    _log.d('Selected sortBy: $sortType');

    //Aggiorno il filtro
    _filter = _filter.setSortType(sortOption: sortType);

    notifyListeners();
  }

  void selectGenre(Genre selectedGenre) {
    _selectedGenres.add(selectedGenre);
    _log.d('Selected genre: ${selectedGenre.name}');

    _filter = FilterBuilder().setGenre(selectedGenre);

    notifyListeners();
  }

  void removeGenre(Genre selectedGenre) {
    _selectedGenres.remove(selectedGenre);
    _log.d('Remove ${selectedGenre.name} genre');

    _filter = FilterBuilder().removeGenre(selectedGenre);

    notifyListeners();
  }

  void applyFilter() {
    //Richiamo la funzione con il filtro corrente
    discoverMoviesByFIlter(_filter.build());
  }

  void clearFilter() {
    _filter = FilterBuilder();
    applyFilter();
    _selectedSortOption = SortOptions.popularity;
    _selectedGenres = {};
    notifyListeners();
  }
}
