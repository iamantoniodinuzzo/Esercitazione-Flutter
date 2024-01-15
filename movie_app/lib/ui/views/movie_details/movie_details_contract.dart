import 'package:movie_app/domain/models/movie/movie_details.dart';
import 'package:movie_app/ui/views/_base/base_contract.dart';
import 'package:movie_app/util/user_interface_state.dart';

class MovieDetailsVMState extends BaseViewModelState {
  late UserInterfaceState<MovieDetails> movieDetails;
  //TODO: variabile per : video, immagini, crediti e altro
}

//dal view model alla view
abstract class MovieDetailsViewContract extends BaseViewContract {
}

//dalla view al view model
abstract class MovieDetailsVMContract extends BaseViewModelContract<
    MovieDetailsVMState, MovieDetailsViewContract> {
  void getMovieDetails(int movieId);

}
