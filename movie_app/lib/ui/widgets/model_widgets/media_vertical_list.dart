import 'package:flutter/material.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';

class MediaVerticalList extends StatelessWidget {
  const MediaVerticalList({
    super.key,
    required this.movies,
    required this.onTap,
  });

  final List<Movie> movies;
  final Function(Movie) onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onTap(movies[index]);
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Left side: Movie Poster
                  Hero(
                      tag: movies[index].id,
                      child: MediaPoster(
                        movie: movies[index],
                      )),
                  // Right side: Movie Details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
