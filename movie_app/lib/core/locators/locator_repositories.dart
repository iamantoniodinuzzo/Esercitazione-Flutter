import 'package:movie_app/core/locators/locator.dart';
import 'package:movie_app/data/modules/services/movie_service.dart';
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/repository/movie_repository_impl.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

void initializeRepositories() {
  getIt.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(
      movieService: getIt<MovieService>(),
      networkMapper: getIt<NetworkMapper>(),
    ),
  );
}
