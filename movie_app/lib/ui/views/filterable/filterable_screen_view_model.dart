import 'package:logger/logger.dart';
import 'package:movie_app/core/network/exception/server_exception_type.dart';
import 'package:movie_app/core/network/network_state.dart';
import 'package:movie_app/di/injector.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';

import '../../../domain/model/filter/sort_type.dart';
import '../../../domain/model/genre/genre.dart';
import '../../../domain/repository/movie_repository.dart';

class FilterableScreenViewModel extends BaseViewModel {
  final MovieRepository _movieRepository = getIt<MovieRepository>();
  final Logger _log = getIt<Logger>();

  final FilterBuilder _filterBuilder = FilterBuilder();

  Filter get appliedFilter => _filterBuilder.build();

  //* Film filtrati
  NetworkState<List<Movie>> _movieDiscovered = Loading();

  NetworkState<List<Movie>> get movieDiscovered => _movieDiscovered;

  //* Generi dei film
  NetworkState<List<Genre>> _movieGenres = Loading();

  NetworkState<List<Genre>> get movieGenres => _movieGenres;

  //* Sort by selezionato
  SortOptions _selectedSortOption = SortOptions.popularity;

  SortOptions get selectedSortOption => _selectedSortOption;

  //* Generi selezionati
  Set<Genre> _selectedGenres = <Genre>{};

  Set<Genre> get selectedGenres => _selectedGenres;

  void onInit() {
    discoverMoviesByFilter(appliedFilter);
    _getMovieGenres();
  }

  void discoverMoviesByFilter(Filter filter) async {
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
    _filterBuilder.setSortType(sortOption: sortType);

    notifyListeners();
  }

  void selectGenre(Genre selectedGenre) {
    _selectedGenres.add(selectedGenre);
    _log.d('Selected genre: ${selectedGenre.name}');

    _filterBuilder.setGenre(selectedGenre);

    notifyListeners();
  }

  void removeGenre(Genre selectedGenre) {
    _selectedGenres.remove(selectedGenre);
    _log.d('Remove ${selectedGenre.name} genre');

    _filterBuilder.removeGenre(selectedGenre);

    notifyListeners();
  }

  void clearGenreSelection() {
    _selectedGenres.clear();
    _log.d('Cleared genre selection');

    _filterBuilder.clearGenreSelection();

    notifyListeners();
  }

  void applyFilter() {
    //Creo il filtro da applicare
    _log.d('Apply filters: $appliedFilter');
    //Richiamo la funzione con il filtro corrente
    discoverMoviesByFilter(appliedFilter);
  }

  void clearFilter() {
    _log.d('Clear all filters');
    //Setto il FilterBuilder allo stato iniziale
    _filterBuilder.clear();
    //Applico i filtri
    applyFilter();
    //Svuoto le selezioni correnti
    _selectedSortOption = SortOptions.popularity;
    _selectedGenres = {};

    notifyListeners();
  }
}
