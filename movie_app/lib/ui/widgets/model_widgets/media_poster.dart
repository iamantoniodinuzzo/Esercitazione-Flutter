import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/movie_app_dimensions.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

import '../../../core/theme/movie_app_colors.dart';
import '../../../core/theme/movie_app_text_style.dart';

class MediaPoster extends StatelessWidget {
  final Movie movie;
  final bool isVoteAverageVisible;
  final bool isClickable;
  final Function()? onTap;
  final double height;
  final double width;

  const MediaPoster({
    super.key,
    required this.movie,
    this.isVoteAverageVisible = true,
    this.isClickable = false,
    this.onTap,
    required this.height,
    required this.width,
  });

  const MediaPoster.big({
    super.key,
    required this.movie,
    this.isVoteAverageVisible = true,
    this.isClickable = true,
    this.onTap,
  })  : height = MovieAppDimensions.bigPosterHeight,
        width = MovieAppDimensions.bigPosterWidth;

  const MediaPoster.small({
    super.key,
    required this.movie,
    this.isVoteAverageVisible = true,
    this.isClickable = true,
    this.onTap,
  })  : height = MovieAppDimensions.smallPosterHeight,
        width = MovieAppDimensions.smallPosterWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              //* Costruisce l'immagine
              _buildCachedNetworkImage(),
              //* Costruisce la chip per la votazione
              Align(
                alignment: Alignment.topRight,
                child: _buildVoteAverageChip(),
              ),
            ],
          ),
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
            style: MovieAppTextStyle.smallTitle.copyWith(fontSize: 12),
            movie.voteAverage.ceilToDouble().toString(),
          ),
        ),
      ),
    );
  }
}
