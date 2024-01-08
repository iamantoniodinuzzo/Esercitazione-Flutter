// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseMediaResponse _$BaseMediaResponseFromJson(Map<String, dynamic> json) =>
    BaseMediaResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$BaseMediaResponseToJson(BaseMediaResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
