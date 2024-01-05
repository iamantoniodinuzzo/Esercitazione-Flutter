import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/domain/model/movie.dart';
import 'package:movie_app/util/constants.dart';
import 'package:movie_app/views/detail.screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: FutureBuilder(
        future: MovieApi().getTrendingMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data != null) {
            List<Media> movies = snapshot.data!;
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
                          Image.network(
                            '${Constants.imagePath}${movies[index].posterPath}',
                            width: 100.0,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
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
