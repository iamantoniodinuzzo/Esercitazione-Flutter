import 'package:movie_app/ui/views/_base/base_contract.dart';
import 'package:movie_app/util/user_interface_state.dart';

import '../../../domain/models/movie/movie.dart';

class HomeVMState extends BaseViewModelState {
 late UserInterfaceState<List<Movie>> trendingMovies;
}

//dal view model alla view
abstract class HomeViewContract extends BaseViewContract {
  void goToMovieDetails(Movie selectedMovie);
}

//Dalla view al view model
abstract class HomeVMContract
    extends BaseViewModelContract<HomeVMState, HomeViewContract> {
  void tapOnMovie(Movie selectedMovie);
  void refreshTrendingMovies();
}
