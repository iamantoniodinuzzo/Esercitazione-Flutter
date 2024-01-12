import 'package:movie_app/domain/model/filter/sort_type.dart';

import '../genre/genre.dart';

class Filter {
  String sortBy;
  String? withGenres;

  Filter._builder(FilterBuilder builder)
      : sortBy = builder.sortBy ?? 'popularity.desc',
        withGenres = builder.withGenres?.map((e) => e.id).join(',');
}

class FilterBuilder {
  String? sortBy;
  Set<Genre>? withGenres;

  FilterBuilder setSortType(
      {SortOptions? sortOption, bool isDescending = true}) {
    sortBy =
        '${sortOption?.sortName ?? SortOptions.popularity.sortName}.${isDescending ? 'desc' : 'asc'}';
    return this;
  }

  FilterBuilder setGenre(Genre genre) {
    if (withGenres == null) {
      withGenres = {genre};
    } else {
      withGenres!.add(genre);
    }
    return this;
  }

  FilterBuilder removeGenre(Genre genre) {
    if (withGenres != null) {
      withGenres!.remove(genre);
    }
    return this;
  }

  FilterBuilder clearGenreSelection() {
    if (withGenres != null) {
      withGenres!.clear();
    }
    return this;
  }

  Filter build() {
    return Filter._builder(this);
  }
}
