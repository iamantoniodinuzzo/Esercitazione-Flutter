import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class MediaSection extends StatelessWidget {
  const MediaSection({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 150,
                  child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagePath}${snapshot.data[index].posterPath}',
                  ),
                ),
              ),
            );
          }),
    );
  }
}
