import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/data/remote/repository/movie_repository_impl.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_media_by_filter.dart';
import 'package:movie_app/domain/usecases/get_media_by_search.dart';
import 'package:movie_app/domain/usecases/get_movie_details.dart';
import 'package:movie_app/domain/usecases/get_movie_genres.dart';
import 'package:movie_app/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/ui/views/details/bloc/media_details_bloc.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_bloc.dart';
import 'package:movie_app/ui/views/home/bloc/home_bloc.dart';
import 'package:movie_app/ui/views/search/bloc/search_media_bloc.dart';

final getIt = GetIt.instance;
Future<void> initializeDependencies() async {
  //* Dio
  getIt.registerSingleton<DioClient>(
      DioClient(apiKey: '9ca2906942298ba2a5a9f3b813ee0491'));

  //* Dependencies
  getIt.registerSingleton<MovieService>(
    MovieService(apiClient: getIt<DioClient>()),
  );

  getIt.registerSingleton<MovieRepository>(
    MovieRepositoryImpl(movieService: getIt<MovieService>()),
  );

  //* UseCases
  getIt.registerSingleton<GetTrendingMoviesUseCase>(
    GetTrendingMoviesUseCase(movieRepository: getIt<MovieRepository>()),
  );
  getIt.registerSingleton<GetMovieDetailsUseCase>(
    GetMovieDetailsUseCase(
      movieRepository: getIt<MovieRepository>(),
    ),
  );
  getIt.registerSingleton<GetMediaBySearchUseCase>(GetMediaBySearchUseCase(
    movieRepository: getIt<MovieRepository>(),
  ));
  getIt.registerSingleton<GetMediaByFilterUseCase>(
    GetMediaByFilterUseCase(movieRepository: getIt<MovieRepository>()),
  );
  getIt.registerSingleton<GetMovieGenresUseCase>(
    GetMovieGenresUseCase(movieRepository: getIt<MovieRepository>()),
  );


  //* Blocs
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<GetTrendingMoviesUseCase>()),
  );
  getIt.registerFactory<MediaDetailsBloc>(
    () => MediaDetailsBloc(getIt<GetMovieDetailsUseCase>()),
  );
  getIt.registerFactory<SearchMediaBloc>(
    () => SearchMediaBloc(getIt<GetMediaBySearchUseCase>()),
  );
  getIt.registerFactory<DiscoverMediaBloc>(
    () => DiscoverMediaBloc(
      getIt<GetMediaByFilterUseCase>(),
      getIt<GetMovieGenresUseCase>(),
    ),
  );
}
