// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/core/network/api_endpoints.dart';
import 'package:movie_app/core/network/perform_api_call.dart';
import 'package:movie_app/data/remote/dto/movie/movie_details_dto.dart';
import 'package:movie_app/data/remote/response/base_media_response.dart';
import 'package:movie_app/data/remote/response/genre_response.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/time_window.dart';

class MovieService {
  final DioClient _dioClient;

  MovieService({
    required DioClient apiClient,
  }) : _dioClient = apiClient;

  Future<BaseMediaResponse> getTrendingMovies(TimeWindow timeWindow) async {
    return performApiCall(
      () => _dioClient.get(
        ApiEndpoints.trending(
          TrendingEndpoint.movie,
          timeWindow: timeWindow,
        ),
      ),
      (json) => BaseMediaResponse.fromJson(json),
    );
  }

  Future<BaseMediaResponse> discoverMovieByFilter(Filter filter) async {
    return performApiCall(
      () => _dioClient.get(ApiEndpoints.discover(DiscoverEndpoint.movie),
          queryParameters: {
            'with_genres': filter.withGenres,
            'sort_by': filter.sortBy
          }),
      (json) => BaseMediaResponse.fromJson(json),
    );
  }

  Future<MovieDetailsDto> getMovieDetails(int movieId) async {
    return performApiCall(
      () => _dioClient.get(
        ApiEndpoints.movies(
          MoviesEndpoint.details,
          movieId,
        ),
      ),
      (json) => MovieDetailsDto.fromJson(json),
    );
  }

  Future<BaseMediaResponse> searchMovie(String query) async {
    return performApiCall(
      () => _dioClient.get(ApiEndpoints.search(SearchEndpoint.movie),
          queryParameters: {'query': query}),
      (json) => BaseMediaResponse.fromJson(json),
    );
  }

  Future<GenreResponse> getMovieGenres() async {
    return performApiCall(
      () => _dioClient.get(
        ApiEndpoints.genres(GenresEndpoint.movieList),
      ),
      (json) => GenreResponse.fromJson(
        json,
      ),
    );
  }
}
