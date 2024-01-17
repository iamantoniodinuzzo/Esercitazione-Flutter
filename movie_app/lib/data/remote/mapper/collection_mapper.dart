import '../../../domain/model/collection/collection.dart';
import '../dto/collection/collection_dto.dart';

extension CollectionMapper on CollectionDto? {
  Collection? mapToDomain() {
    var mirror = this;
    return mirror != null
        ? Collection(
            id: mirror.id, name: mirror.name, backdropPath: mirror.backdropPath)
        : null;
  }
}
