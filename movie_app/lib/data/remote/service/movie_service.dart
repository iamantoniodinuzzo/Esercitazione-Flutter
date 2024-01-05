import 'package:movie_app/data/remote/response/trending_movies_response.dart';
import 'package:movie_app/data/remote/service/client/tmdb_client.dart';
import 'package:movie_app/domain/exception/network_exception.dart';

class MovieService {
  final TmdbClient _apiClient = TmdbClient();

  Future<TrendingMoviesResponse> getTrendingMovies(String timeWindow) async {
    //TODO: TimeWidow dovrebbe essere una enumerazione
    try {
      final response = await _apiClient.get('/trending/movie/$timeWindow');
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
}
