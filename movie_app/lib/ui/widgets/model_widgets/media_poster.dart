import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/texts.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
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
