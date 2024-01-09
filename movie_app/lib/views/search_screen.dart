import 'package:flutter/material.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_tile_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchMovie(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchMovie(context);
  }

  FutureBuilder<List<Movie>> _searchMovie(BuildContext context) {
    final moviesRepository =
        Provider.of<MovieRepository>(context, listen: false);

    return FutureBuilder(
        future: moviesRepository.searchMovie(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Movie> medias = snapshot.data!;
            if (medias.isEmpty) {
              return const Center(
                child: Text(
                  'Seems empty here, search some movies',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                   ),
                ),
              );
            } else {
              return MediaTileList(
                movies: medias,
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(
                'Seems empty here!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            );
          }
        });
  }
}
