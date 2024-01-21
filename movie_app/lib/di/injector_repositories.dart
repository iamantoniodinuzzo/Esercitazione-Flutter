import 'package:movie_app/data/remote/repository/movie_repository_impl.dart';
import 'package:movie_app/di/injector_services.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';
import 'package:riverpod/riverpod.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final movieService = ref.read(movieServiceProvider);
  return MovieRepositoryImpl(movieService: movieService);
});
