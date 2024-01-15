import 'package:flutter/material.dart';
import 'package:movie_app/util/time_window.dart';

/// A utility class for getting paths for API endpoints.
/// This class has no constructor and all methods are `static`.
@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imagePathW500 = 'https://image.tmdb.org/t/p/w500';
  static const String imagePathOriginal = 'https://image.tmdb.org/t/p/original';

  //Return the path for trending [endpoint]
  static String trending(TrendingEndpoint endpoint,
      {TimeWindow timeWindow = TimeWindow.week}) {
    const path = '/trending';
    switch (endpoint) {
      case TrendingEndpoint.movie:
        return '$path/movie/${timeWindow.name}';
      case TrendingEndpoint.tv:
        return '$path/tv/${timeWindow.name}';
      case TrendingEndpoint.people:
        return '$path/people/${timeWindow.name}';
      case TrendingEndpoint.all:
        return '$path/all/${timeWindow.name}';
    }
  }

  ///Return the path for a movie [endpoint].
  ///
  ///Specify movie [movieId] to get the path for a specific movie.
  static String movies(MoviesEndpoint endpoint, int movieId) {
    const path = '/movie';
    switch (endpoint) {
      case MoviesEndpoint.details:
        return '$path/$movieId';
      case MoviesEndpoint.credits:
        return '$path/$movieId/credits';
      case MoviesEndpoint.images:
        return '$path/$movieId/images';
      case MoviesEndpoint.lists:
        return '$path/$movieId/lists';
      case MoviesEndpoint.recommendations:
        return '$path/$movieId/recommendations';
      case MoviesEndpoint.releaseDates:
        return '$path/$movieId/release_dates';
      case MoviesEndpoint.similar:
        return '$path/$movieId/similar';
      case MoviesEndpoint.videos:
        return '$path/$movieId/videos';
      case MoviesEndpoint.watchProviders:
        return '$path/$movieId/watch/providers';
    }
  }

  ///Return the path for a search [endpoint].
  static String search(SearchEndpoint endpoint) {
    const path = '/search';
    switch (endpoint) {
      case SearchEndpoint.movie:
        return '$path/movie';
    }
  }

  //Return the path for discover [endpoint].
  static String discover(DiscoverEndpoint endpoint) {
    const path = '/discover';
    switch (endpoint) {
      case DiscoverEndpoint.movie:
        return '$path/movie';
    }
  }

  //Return the path for genre list [endpoint].
  static String genres(GenresEndpoint endpoint) {
    const path = '/genre';
    switch (endpoint) {
      case GenresEndpoint.movieList:
        return '$path/movie/list';
    }
  }
}

enum TrendingEndpoint {
  movie,
  tv,
  people,
  all;
}

enum MoviesEndpoint {
  details,
  credits,
  images,
  lists,
  recommendations,
  releaseDates,
  similar,
  videos,
  watchProviders;
}

enum SearchEndpoint {
  movie;
}

enum DiscoverEndpoint {
  movie;
}

enum GenresEndpoint {
  movieList;
}
