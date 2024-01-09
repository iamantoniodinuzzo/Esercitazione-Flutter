import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/views/details/detail_screen.dart';


class MediaTileList extends StatelessWidget {
  const MediaTileList({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
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
  }
}
