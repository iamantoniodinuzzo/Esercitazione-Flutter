import 'package:json_annotation/json_annotation.dart';
import '../dto/movie/movie_dto.dart';

part 'trending_movies_response.g.dart';

@JsonSerializable()
class TrendingMoviesResponse {
  final int page;
  final List<MovieDto> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  TrendingMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TrendingMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingMoviesResponseToJson(this);
}

