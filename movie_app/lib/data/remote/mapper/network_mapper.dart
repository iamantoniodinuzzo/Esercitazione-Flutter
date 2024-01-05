// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logger/logger.dart';
import 'package:movie_app/data/remote/dto/movie_dto.dart';
import 'package:movie_app/domain/exception/mapper_exception.dart';
import 'package:movie_app/domain/model/movie.dart';

class NetworkMapper {
  final Logger log;

  NetworkMapper({
    required this.log,
  });

  Movie toMovie(MovieDto movieDto) {
    try {
      return Movie(
          adult: movieDto.adult,
          backdropPath: movieDto.backdropPath,
          id: movieDto.id,
          title: movieDto.title,
          posterPath: movieDto.posterPath,
          genreIds: movieDto.genreIds,
          popularity: movieDto.popularity,
          releaseDate: movieDto.releaseDate,
          voteAverage: movieDto.voteAverage);
    } catch (e) {
      log.w(
          'Could not map dto: (${movieDto.id}) ${movieDto.title} cause-> ${e.toString()}');
      throw MapperException<MovieDto, Movie>(message: e.toString());
    }
  }

  List<Movie> toMovies(List<MovieDto> movieDtoList) {
    final List<Movie> movies = [];

    for (final movieDto in movieDtoList) {
      try {
        movies.add(toMovie(movieDto));
      } catch (e) {
        log.w(
            'Could not map dto: (${movieDto.id}) ${movieDto.title} cause -> ${e.toString()} ');
        throw MapperException<List<MovieDto>, List<Movie>>(
            message: e.toString());
      }
    }
    return movies;
  }
}
