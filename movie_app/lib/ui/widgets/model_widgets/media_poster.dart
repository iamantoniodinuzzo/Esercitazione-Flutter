import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/ui/theme/colors.dart';
import 'package:movie_app/ui/theme/texts.dart';

//! La view del poster deve essere migliorata
class MediaPoster extends StatelessWidget {
  final Movie movie;
  final bool isVoteAverageVisible;
  final bool isClickable;

  const MediaPoster({
    super.key,
    required this.movie,
    this.isVoteAverageVisible = true,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildCachedNetworkImage(),
            Align(
              alignment: Alignment.topRight,
              child: _buildVoteAverageChip(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCachedNetworkImage() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
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
