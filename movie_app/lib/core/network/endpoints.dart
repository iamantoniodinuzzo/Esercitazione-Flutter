class Endpoints {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imagePathW500 = 'https://image.tmdb.org/t/p/w500';
  static const String imagePathOriginal = 'https://image.tmdb.org/t/p/original';

  static const String _trending = '/trending/';
  static const String trendingMovies = '${_trending}movie/';
  static const String movieDetails = '/movie/';
  static const String _search = '/search/';
  static const String searchMovie = '${_search}movie';
}
