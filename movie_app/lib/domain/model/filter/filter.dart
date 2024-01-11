import 'package:movie_app/domain/model/filter/sort_type.dart';

class Filter {
  String sortBy;
  String? withGenres;

  Filter._builder(Builder builder)
      : sortBy = builder.sortBy ?? 'popularity.desc',
        withGenres = builder.withGenres?.join(',');

  factory Filter(Builder builder) {
    return Filter._builder(builder);
  }

  static Builder builder() {
    return Builder();
  }
}

class Builder {
  String? sortBy;
  Set<String>? withGenres;

  Builder setSortType(
      {SortOptions? sortOption, bool isDescending = true}) {
    sortBy =
        '${sortOption?.sortName ?? SortOptions.popularity.sortName}.${isDescending ? 'desc' : 'asc'}';
    return this;
  }

  Builder setGenre(String genre) {
    if (withGenres == null) {
      withGenres = {genre};
    } else {
      withGenres!.add(genre);
    }
    return this;
  }

  Builder removeGenre(String genre) {
    if (withGenres != null) {
      withGenres!.remove(genre);
    }
    return this;
  }

  Filter build() {
    return Filter._builder(this);
  }
}