import 'package:movie_app/domain/models/filter/filter.dart';
import 'package:movie_app/domain/models/filter/sort_type.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../../domain/models/genre/genre.dart';
import '../../../domain/models/movie/movie.dart';
import '../_base/base_contract.dart';

class FilterableMediaVMState extends BaseViewModelState {
  late final UserInterfaceState<List<Movie>> filteredMovies;
  late final UserInterfaceState<List<Genre>> movieGenreList;

  SortOptions selectedSortBy = SortOptions.popularity;
  final Set<Genre> selectedGenres = {};
  final FilterBuilder filterBuilder = FilterBuilder();

  Filter get appliedFilter => filterBuilder.build();
}

//Eventi per la view
abstract class FilterableMediaViewContract extends BaseViewContract {

}

//Dal view model alla view
abstract class FilterableMediaVMContract extends BaseViewModelContract<
    FilterableMediaVMState, FilterableMediaViewContract> {

  void onSelectGenre(Genre genre);
  void onRemoveGenre(Genre genre);
  void onClearGenreSelection();
  void onSelectSortOptions(SortOptions selectedSortOption);
  void onApplyFilter();
  void onClearFilter();
}
