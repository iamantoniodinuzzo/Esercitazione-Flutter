import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/theme/texts.dart';

class MediaPoster extends StatelessWidget {
  final Movie movie;

  const MediaPoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.completePosterPathOriginal,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Chip(
                    label: Text(
                      style: MovieAppTextStyle.secondaryPBold.copyWith(fontSize: 10),
                      movie.voteAverage.ceilToDouble().toString(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
