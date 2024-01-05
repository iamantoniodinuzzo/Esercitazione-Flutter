// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logger/logger.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/response/trending_movies_response.dart';
import 'package:movie_app/data/remote/service/client/tmdb_client.dart';
import 'package:movie_app/domain/exception/network_exception.dart';

class MovieService {
  final TmdbClient apiClient;
  final Logger log;
  
  MovieService(
    this.log, {
    required this.apiClient,
  });

  Future<TrendingMoviesResponse> getTrendingMovies(String timeWindow) async {
    try {
      final response = await apiClient.get('/trending/movie/$timeWindow');
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
            statusCode: response.statusCode!, message: response.statusMessage);
      } else if (response.statusCode != null) {
        return TrendingMoviesResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<MovieDetailsDto> getMovieDetails(int movieId) async {
    try {
      final response = await apiClient.get('/movie/$movieId');
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
            statusCode: response.statusCode!, message: response.statusMessage);
      } else if (response.statusCode != null) {
        return MovieDetailsDto.fromJson(response.data);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      rethrow;
    }
  }
}
