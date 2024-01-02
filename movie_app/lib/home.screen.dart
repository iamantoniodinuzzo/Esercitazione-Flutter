import 'package:flutter/material.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/models/media.dart';

import 'widgets/media_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Media>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trending Movies',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MediaSection(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
