import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:movie_app/views/details/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.selectedMedia});

  final Movie selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var appBarHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final detailViewModel =
        Provider.of<DetailViewModel>(context, listen: false);

    //? Quante volte viene effettuata questa chiamata
    detailViewModel.getMovieDetails(widget.selectedMedia.id);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                appBarHeight = constraints.biggest.height;
                return FlexibleSpaceBar(
                  //* Titolo visibile solo se app bar collassata
                  title: _CollapsedTitle(
                    appBarHeight: appBarHeight,
                    title: widget.selectedMedia.title,
                  ),
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // * Immagine di sfondo
                      Positioned.fill(
                        bottom: 100,
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          imageUrl:
                              widget.selectedMedia.completeBackdropPathOriginal,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                      // * Contenuto sovrapposto
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // * Poster
                            Hero(
                              tag: widget.selectedMedia.id,
                              child: MediaPoster(movie: widget.selectedMedia),
                            ),
                            const SizedBox(width: 16.0),
                            //* Titolo
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                widget.selectedMedia.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
        body: Consumer<DetailViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.movieDetails) {
              //* Success
              case Success<MovieDetails>(data: var data):
                MovieDetails? movieDetails = data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetails.tagline,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(movieDetails.overview),
                        const SizedBox(height: 16.0),
                        Text(
                          'Genres',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: (movieDetails.genres)
                              .map(
                                (genre) => Chip(
                                  label: Text(genre.name),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Release Date: ${movieDetails.releaseDate}',
                        ),
                        Text('Tagline: ${movieDetails.tagline}'),
                        Text('Original Title: ${movieDetails.originalTitle}'),
                        Text('Language: ${movieDetails.originalLanguage}'),
                        Text('Budget: ${movieDetails.budget}'),
                      ],
                    ),
                  ),
                );
              case Error<MovieDetails>(message: var message):
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Error movieId(${widget.selectedMedia.id}): $message',
                    ),
                  ),
                );
              case Loading<MovieDetails>():
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}

class _CollapsedTitle extends StatelessWidget {
  const _CollapsedTitle({
    required this.appBarHeight,
    required this.title,
  });

  final double appBarHeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity:
          appBarHeight == MediaQuery.of(context).padding.top + kToolbarHeight
              ? 1.0
              : 0.0,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
