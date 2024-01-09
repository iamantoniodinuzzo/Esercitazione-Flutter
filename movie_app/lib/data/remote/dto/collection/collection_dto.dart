// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_dto.g.dart';

@JsonSerializable()
class CollectionDto {
  final int id;
  final String name;
  @JsonKey(name:'poster_path')
  final String posterPath;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  
  CollectionDto({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

   factory CollectionDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionDtoToJson(this);
}
