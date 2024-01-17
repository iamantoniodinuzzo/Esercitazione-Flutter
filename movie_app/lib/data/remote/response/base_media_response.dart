import 'package:freezed_annotation/freezed_annotation.dart';

import '../dto/movie/movie_dto.dart';

part 'base_media_response.g.dart';

@JsonSerializable()
class BaseMediaResponse {
  final int page;
  final List<MovieDto> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;

  BaseMediaResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory BaseMediaResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseMediaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseMediaResponseToJson(this);
}

