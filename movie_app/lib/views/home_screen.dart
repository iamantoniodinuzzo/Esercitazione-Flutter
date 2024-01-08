import 'package:flutter/material.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/util/time_widow.dart';
import 'package:movie_app/views/search_screen.dart';
import 'package:provider/provider.dart';

import '../res/components/media_tile_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesRepository =
        Provider.of<MovieRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchScreen(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: moviesRepository.getTrendingMovies(TimeWidow.week),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Movie> movies = snapshot.data!;
            return MediaTileList(movies: movies);
          } else {
            return const Center(
              child: Column(
                children: [
                  Text(
                    'Seems empty here!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
