import '../../../domain/model/genre/genre.dart';
import '../dto/genre/genre_dto.dart';

extension GenreMapper on GenreDto {
  Genre mapToDomain() {
    return Genre(id: id, name: name);
  }
}

extension GenresMapper on Iterable<GenreDto> {
  Iterable<Genre> mapToDomain() {
    return map((e) => e.mapToDomain());
  }
}
