// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/data/remote/mapper/network_mapper.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/util/time_widow.dart';

class MovieRepository {
  final MovieService movieService;
  final NetworkMapper networkMapper;

  MovieRepository({
    required this.movieService,
    required this.networkMapper,
  });

  Future<List<Movie>> getTrendingMovies(TimeWidow timeWindow) async {
    final trendingMovies =
        await movieService.getTrendingMovies(timeWindow.name);
    final mappedResult = networkMapper.toMovies(trendingMovies.results);
    return mappedResult;
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final movieDetails = await movieService.getMovieDetails(movieId);
    final mappedResult = networkMapper.toMovieDetails(movieDetails);
    return mappedResult;
  }
}
