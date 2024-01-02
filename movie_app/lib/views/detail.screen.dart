import 'package:flutter/material.dart';
import 'package:movie_app/models/media.dart';
import 'package:movie_app/util/constants.dart';
import 'package:movie_app/views/home.screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.selectedMedia});
  final Media selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
        body: const Center(
          child: Text('Sample text'),
        ),
      ),
    );
  }
}
