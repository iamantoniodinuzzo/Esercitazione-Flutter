import '../../../domain/model/spoken_language/spoken_language.dart';
import '../dto/spoken_language/spoken_language_dto.dart';

extension SpokenLanguageMapper on SpokenLanguageDto {
  SpokenLanguage mapToDomain() {
    return SpokenLanguage(englishName: englishName, name: name);
  }
}

extension SpokenLanguagesMapper on Iterable<SpokenLanguageDto> {
  Iterable<SpokenLanguage> mapToDomain() {
    return map((e) => e.mapToDomain());
  }
}
