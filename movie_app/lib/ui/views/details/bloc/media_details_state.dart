import 'package:movie_app/domain/model/movie/movie_details.dart';

sealed class MediaDetailsState {
  final MovieDetails? movieDetails;
  final String? errorMessage;

  const MediaDetailsState({this.errorMessage, this.movieDetails});
}

class MediaDetailsLoaded extends MediaDetailsState {
  MediaDetailsLoaded({super.movieDetails});
}

class MediaDetailsLoading extends MediaDetailsState {
  const MediaDetailsLoading();
}

class MediaDetailsError extends MediaDetailsState {
  const MediaDetailsError({super.errorMessage});
}
