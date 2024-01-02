import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/models/media.dart';
import 'package:movie_app/models/media.details.dart';
import 'package:movie_app/util/constants.dart';
import 'package:movie_app/views/home.screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.selectedMedia});
  final Media selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MediaDetails> _selectedMediaDetails;

  @override
  void initState() {
    super.initState();
    final selectedMedia = widget.selectedMedia;
    _selectedMediaDetails = fetchData(selectedMedia.id);
  }

  Future<MediaDetails> fetchData(int mediaId) async {
    // Simulare una chiamata asincrona
    await Future.delayed(const Duration(seconds: 3));

    // Effettuare la chiamata e restituire il risultato
    var result = MovieApi().getMovieDetails(mediaId);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final selectedMedia = widget.selectedMedia;

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                floating: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(selectedMedia.title),
                  background: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagePath}${selectedMedia.backdropPath}',
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder(
            future: _selectedMediaDetails,
            builder: (context, snapshot) {
              print('Mostrare i dettagli di ${selectedMedia.id}');
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                      'Mostrare i dettagli del film con id (${selectedMedia.id})'),
                );
              } else if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
