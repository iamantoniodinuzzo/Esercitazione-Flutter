import 'package:movie_app/domain/model/movie/movie.dart';

import '../dto/movie/movie_dto.dart';

extension MovieMapper on MovieDto {
  Movie mapToDomain() {
    return Movie(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      title: title,
      posterPath: posterPath,
      genreIds: genreIds,
      popularity: popularity,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
    );
  }
}

extension MoviesMapper on Iterable<MovieDto>{
  Iterable<Movie> mapToDomain(){
    return map((e) => e.mapToDomain());
  }
}
