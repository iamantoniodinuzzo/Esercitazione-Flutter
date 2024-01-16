import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/remote/repository/movie_repository_impl.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/di/injector.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

void initializeRepositories() {
  getIt.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(
      movieService: getIt<MovieService>(),
      networkMapper: getIt<NetworkMapper>(),
    ),
  );
}
