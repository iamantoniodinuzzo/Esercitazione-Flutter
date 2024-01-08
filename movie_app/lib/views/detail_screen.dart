import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
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
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.selectedMedia.title),
                background: Hero(
                  tag: widget.selectedMedia.id,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: widget.selectedMedia.completePosterPathW500,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(
                      value: progress.progress,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
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
                      const SizedBox(height: 16.0),
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
                            .map((genre) => Chip(label: Text(genre.name)))
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
