import 'package:flutter/material.dart';
import 'package:movie_app/data/remote/repository/movie_repository.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/util/constants.dart';
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
      body: FutureBuilder<MovieDetails>(
        future: movieRepository.getMovieDetails(widget.selectedMedia.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Error movieId(${widget.selectedMedia.id}): ${snapshot.error}',
                ),
              ),
            );
          } else if (snapshot.hasData) {
            MovieDetails? movieDetails = snapshot.data;
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(widget.selectedMedia.title),
                      background: Image.network(
                        '${Constants.imagePathW500}${movieDetails?.backdropPath ?? ""}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
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
                        'Release Date: ${movieDetails?.releaseDate.toLocal()}',
                      ),
                      Text('Tagline: ${movieDetails?.tagline}'),
                      Text('Original Title: ${movieDetails?.originalTitle}'),
                      Text('Language: ${movieDetails?.originalLanguage}'),
                      Text('Budget: ${movieDetails?.budget}'),
                    ],
                  ),
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
    );
  }
}
