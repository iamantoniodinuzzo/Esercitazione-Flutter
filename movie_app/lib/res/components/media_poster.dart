import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

class MediaPoster extends StatelessWidget {
  final Movie movie;

  const MediaPoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          //Media poster
          SizedBox(
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: movie.completePosterPathOriginal,
                progressIndicatorBuilder: (context, url, progress) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(movie.title)),
                    const SizedBox(height: 5.0),
                    Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                  ],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          )
        ],
      ),
    );
  }
}
