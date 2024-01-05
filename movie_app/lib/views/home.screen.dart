import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/util/constants.dart';
import 'package:movie_app/util/time_widow.dart';
import 'package:movie_app/views/detail.screen.dart';
import 'package:provider/provider.dart';

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
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(selectedMedia: movies[index]),
                      ),
                    );
                  },
                  child: Material(
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Left side: Movie Poster
                          Hero(
                              tag: movies[index].id,
                              child: MediaPoster(movie: movies[index])),
                          // Right side: Movie Details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movies[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                      'Vote Average: ${movies[index].voteAverage}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
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
