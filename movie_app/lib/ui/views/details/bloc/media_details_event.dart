import 'package:movie_app/domain/model/movie/movie.dart';

abstract class MediaDetailsEvent {
  const MediaDetailsEvent();
}

class GetMovieDetails extends MediaDetailsEvent {
  final Movie selectedMovie;

  GetMovieDetails({required this.selectedMovie});
}