import 'package:logger/logger.dart';
import 'package:movie_app/core/locators/locator.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/ui/views/home/home_contract.dart';
import 'package:movie_app/ui/views/home/home_view_model.dart';

void initializeScreens() {
  //HomeView
  getIt.registerFactory<HomeVMContract>(
    () => HomeViewModel(
        movieRepository: getIt<MovieRepository>(), log: getIt<Logger>()),
  );
  getIt.registerFactory<HomeVMState>(() => HomeVMState());
}
