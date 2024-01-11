import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/theme/texts.dart';

class MediaPoster extends StatelessWidget {
  final Movie movie;
  final bool isVoteAverageVisible;

  const MediaPoster({
    super.key,
    required this.movie,
    this.isVoteAverageVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 150,
        width: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              _buildCachedNetworkImage(),
              _buildVoteAverageChip(),
            ],
          ),
        ),
      ),
    );
  }

  CachedNetworkImage _buildCachedNetworkImage() {
    return CachedNetworkImage(
              imageUrl: movie.completePosterPathOriginal,
              progressIndicatorBuilder: (context, url, progress) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    movie.title,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
  }

  Widget _buildVoteAverageChip() {
    return Visibility(
      visible: isVoteAverageVisible,
      child: Opacity(
        opacity: 0.5,
        child: Chip(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          // Imposta il padding per allungare il chip
          backgroundColor: MovieAppColors.primary,
          label: Text(
            style: MovieAppTextStyle.secondaryPBold.copyWith(fontSize: 12),
            movie.voteAverage.ceilToDouble().toString(),
          ),
        ),
      ),
    );
  }
}
