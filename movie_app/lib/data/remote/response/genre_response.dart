import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/remote/dto/genre/genre_dto.dart';

part 'genre_response.g.dart';

@JsonSerializable()
class GenreResponse {
  @JsonKey(name: "genres")
  final List<GenreDto> genres;

  GenreResponse({
    required this.genres,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}
