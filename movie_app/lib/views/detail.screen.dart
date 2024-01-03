import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/models/media.dart';
import 'package:movie_app/models/media.details.dart';
import 'package:movie_app/util/constants.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.selectedMedia}) : super(key: key);

  final Media selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MediaDetails> _futureMovieDetails;

  @override
  void initState() {
    super.initState();
    _futureMovieDetails = MovieApi().getMovieDetails(widget.selectedMedia.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureMovieDetails,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    'Error movieId(${widget.selectedMedia.id}): ${snapshot.error}'),
              ),
            );
          } else if (snapshot.hasData) {
            MediaDetails? movieDetails = snapshot.data;
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
                        '${Constants.imagePath}${movieDetails?.backdropPath ?? ""}',
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
