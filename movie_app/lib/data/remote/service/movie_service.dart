// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:logger/logger.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/core/network/endpoints.dart';
import 'package:movie_app/core/network/perform_api_call.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/response/base_media_response.dart';

class MovieService {
  final DioClient apiClient;
  final Logger log;

  MovieService(
    this.log, {
    required this.apiClient,
  });

  Future<BaseMediaResponse> getTrendingMovies(String timeWindow) async {
    return performApiCall(
      () => apiClient.get('${Endpoints.trendingMovies}$timeWindow'),
      (json) => BaseMediaResponse.fromJson(json),
    );
  }

  Future<MovieDetailsDto> getMovieDetails(int movieId) async {
    return performApiCall(
      () => apiClient.get('${Endpoints.movieDetails}$movieId'),
      (json) => MovieDetailsDto.fromJson(json),
    );
  }

  Future<BaseMediaResponse> searchMovie(String query) async {
    return performApiCall(
      () => apiClient
          .get(Endpoints.searchMovie, queryParameters: {'query': query}),
      (json) => BaseMediaResponse.fromJson(json),
    );
  }
}
