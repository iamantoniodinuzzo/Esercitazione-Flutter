import 'package:movie_app/domain/model/movie_details.dart';
import 'package:movie_app/util/constants.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieApi {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _movieDetailsUrl = 'https://api.themoviedb.org/3/movie/';

  Future<List<Media>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((media) => Media.fromJson(media)).toList();
    } else {
      throw Exception('Something happened, error code: ${response.statusCode}');
    }
  }

  Future<MediaDetails> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$_movieDetailsUrl$movieId?api_key=${Constants.apiKey}'),
    );
    if (response.statusCode == 200) {
      final decodedData = mediaDetailsFromJson(response.body);
      return decodedData;
    } else {
      throw Exception('Something happened, error code: ${response.statusCode}');
    }
  }
}
