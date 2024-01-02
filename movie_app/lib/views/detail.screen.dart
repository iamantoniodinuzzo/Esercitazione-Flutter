import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Movie title'),
                background: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
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
