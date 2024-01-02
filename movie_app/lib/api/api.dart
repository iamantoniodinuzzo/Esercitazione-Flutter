import 'package:movie_app/constants.dart';
import 'package:movie_app/models/media.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  Future<List<Media>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
    }
  }
}
