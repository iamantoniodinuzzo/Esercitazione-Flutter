import 'package:logger/logger.dart';
import 'package:movie_app/core/locators/locator.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/ui/views/home/home_contract.dart';
import 'package:movie_app/ui/views/home/home_view_model.dart';
import 'package:movie_app/ui/views/movie_details/movie_details_contract.dart';
import 'package:movie_app/ui/views/movie_details/movie_details_view_model.dart';

void initializeScreens() {
  //HomeView
  getIt.registerFactory<HomeVMContract>(
    () => HomeViewModel(
        movieRepository: getIt<MovieRepository>(), log: getIt<Logger>()),
  );
  getIt.registerFactory<HomeVMState>(() => HomeVMState());

  //MovieDetails
  getIt.registerFactory<MovieDetailsVMContract>(
    () => MovieDetailsViewModel(
      movieRepository: getIt<MovieRepository>(),
      log: getIt<Logger>(),
    ),
  );
  getIt.registerFactory<MovieDetailsVMState>(() => MovieDetailsVMState());
}
