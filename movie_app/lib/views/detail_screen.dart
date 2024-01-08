import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.selectedMedia});

  final Movie selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movieRepository =
        Provider.of<MovieRepository>(context, listen: false);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // * Immagine di sfondo
                    CachedNetworkImage(
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
                                Colors.black.withOpacity(0.5),
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
                    // * Contenuto sovrapposto
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Poster
                          Hero(
                            tag: widget.selectedMedia.id,
                            child: MediaPoster(movie: widget.selectedMedia),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              widget.selectedMedia.title,
                              style: const TextStyle(
                                color: Colors.white,
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
              ),
            ),
          ];
        },
        body: FutureBuilder<MovieDetails>(
          future: movieRepository.getMovieDetails(widget.selectedMedia.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MovieDetails? movieDetails = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(movieDetails?.overview ?? ''),
                      const SizedBox(height: 16.0),
                      Text(
                        'Genres',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: (movieDetails?.genres ?? [])
                            .map(
                              (genre) => Chip(
                                label: Text(genre.name),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Release Date: ${movieDetails?.releaseDate}',
                      ),
                      Text('Tagline: ${movieDetails?.tagline}'),
                      Text('Original Title: ${movieDetails?.originalTitle}'),
                      Text('Language: ${movieDetails?.originalLanguage}'),
                      Text('Budget: ${movieDetails?.budget}'),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Error movieId(${widget.selectedMedia.id}): ${snapshot.error}',
                  ),
                ),
              );
            } else {
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
