import 'package:logger/logger.dart';
import 'package:movie_app/core/error/exception/server_exception_type.dart';
import 'package:movie_app/domain/models/filter/filter.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/ui/views/_base/base_view_model.dart';
import 'package:movie_app/ui/views/filterable/filterable_media_contract.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../../data/repository/movie_repository_impl.dart';
import '../../../domain/models/filter/sort_type.dart';
import '../../../domain/models/genre/genre.dart';
import '../../../domain/repository/movie_repository.dart';

class FilterableMediaViewModel
    extends BaseViewModel<FilterableMediaVMState, FilterableMediaViewContract>
    implements FilterableMediaVMContract {
  final MovieRepository _movieRepository;
  final Logger _log;

  @override
  void onInitViewState() async {
    vmState.filteredMovies = Loading();
    vmState.movieGenreList = Loading();
    await _getMovieGenres();
    await _discoverMoviesByFilter(vmState.appliedFilter);
  }

  FilterableMediaViewModel(
      {required MovieRepository movieRepository, required Logger log})
      : _movieRepository = movieRepository,
        _log = log;

  Future<void> _discoverMoviesByFilter(Filter filter) async {
    _log.d('Discover movies with this filter $filter');
    try {
      var result = await _movieRepository.discoverMovieByFilter(filter);
      vmState.filteredMovies = Success<List<Movie>>(data: result);
      _log.d('Movies discovered');
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movies', error: e);
      vmState.filteredMovies = Error(message: e.message);
    }
    notifyListeners();
  }

  Future<void> _getMovieGenres() async {
    _log.d('Retrieve movie\'s genres');
    try {
      var result = await _movieRepository.getMovieGenres();
      vmState.movieGenreList = Success<List<Genre>>(data: result);
      _log.d('Movie genres retrieved');
    } on ServerException catch (e) {
      _log.e('An error occurred while retrieving movie genres', error: e);
      vmState.movieGenreList = Error(message: e.message);
    }
    notifyListeners();
  }

  @override
  void onApplyFilter() {
    //Creo il filtro da applicare
    _log.d('Apply filters: ${vmState.appliedFilter}');
    //Richiamo la funzione con il filtro corrente
    _discoverMoviesByFilter(vmState.appliedFilter);
  }

  @override
  void onClearFilter() {
    _log.d('Clear all filters');
    //Setto il FilterBuilder allo stato iniziale
    vmState.filterBuilder.clear();

    //Applico i filtri
    onApplyFilter();

    //Svuoto le selezioni correnti
    vmState.selectedSortBy = SortOptions.popularity;
    vmState.selectedGenres.clear();

    notifyListeners();
  }

  @override
  void onSelectGenre(Genre genre) {
    vmState.selectedGenres.add(genre);
    _log.d('Selected genre: ${genre.name}');

    vmState.filterBuilder.setGenre(genre);

    notifyListeners();
  }

  @override
  void onSelectSortOptions(SortOptions selectedSortOption) {
    vmState.selectedSortBy = selectedSortOption;
    _log.d('Selected sortBy: $selectedSortOption');

    //Aggiorno il filtro
    vmState.filterBuilder.setSortType(sortOption: selectedSortOption);

    notifyListeners();
  }

  @override
  void onClearGenreSelection() {
    vmState.selectedGenres.clear();
    _log.d('Cleared genre selection');

    vmState.filterBuilder.clearGenreSelection();

    notifyListeners();
  }

  @override
  void onRemoveGenre(Genre genre) {
    vmState.selectedGenres.remove(genre);
    _log.d('Remove ${genre.name} genre');

    vmState.filterBuilder.removeGenre(genre);

    notifyListeners();
  }
}
