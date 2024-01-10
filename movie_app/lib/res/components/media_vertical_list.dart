import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/views/routes/app_routes.dart';

class MediaVerticalList extends StatelessWidget {
  const MediaVerticalList({
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
            context.pushNamed(
              AppRoutes.details.name,
              extra: movies[index],
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
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text('Vote Average: ${movies[index].voteAverage}'),
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
