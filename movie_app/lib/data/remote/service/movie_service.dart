// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:logger/logger.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/core/network/endpoints.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/response/base_media_response.dart';
import 'package:movie_app/domain/exception/network_exception.dart';

class MovieService {
  //final TmdbClient apiClient;
  final DioClient apiClient;
  final Logger log;

  MovieService(
    this.log, {
    required this.apiClient,
  });

  /// Restiruisce i film in tendenza fornita una finestra di tempo
  Future<BaseMediaResponse> getTrendingMovies(String timeWindow) async {
    try {
      final response =
          await apiClient.get('${Endpoints.trendingMovies}$timeWindow');
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
            statusCode: response.statusCode!, message: response.statusMessage);
      } else if (response.statusCode != null) {
        return BaseMediaResponse.fromJson(response.data);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      rethrow;
    }
  }

  ///Restituisce i dettagli di un film fornito il suoi identificativo
  Future<MovieDetailsDto> getMovieDetails(int movieId) async {
    try {
      final response = await apiClient.get('${Endpoints.movieDetails}$movieId');
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

  Future<BaseMediaResponse> searchMovie(String query) async {
    try {
      final response = await apiClient
          .get(Endpoints.searchMovie, queryParameters: {'query': query});

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
            statusCode: response.statusCode!, message: response.statusMessage);
      } else if (response.statusCode != null) {
        var mappedResponse = BaseMediaResponse.fromJson(response.data);
        return mappedResponse;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      log.e('Errore in searchMovie: $error', error: error);
      rethrow;
    }
  }
}
