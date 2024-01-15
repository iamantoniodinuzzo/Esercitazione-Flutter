import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/ui/views/_base/base_view_widget_state.dart';
import 'package:movie_app/ui/views/home/home_contract.dart';
import 'package:movie_app/util/user_interface_state.dart';
import '../../widgets/model_widgets/media_vertical_list.dart';
import '../../routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState
    extends BaseViewWidgetState<HomeView, HomeVMContract, HomeVMState>
    implements HomeViewContract {

  @override
  void goToMovieDetails(Movie selectedMovie) {
    context.pushNamed(
      AppRoutes.details.name,
      extra: selectedMovie,
    );
  }

  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          switch (vmState.trendingMovies) {
            Success<List<Movie>>(data: var movies) => MediaVerticalList(
                movies: movies,
                onTap: (Movie selectedMovie) {
                  vmContract.tapOnMovie(selectedMovie);
                },
              ),
            Error(message: var message) => Center(
                child: Text(message),
              ),
            Loading<List<Movie>>() => const Center(
                child: CircularProgressIndicator(),
              ),
          }
        ],
      ),
    );
  }
}
