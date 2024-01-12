import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/theme/texts.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:movie_app/views/filterable/filterable_screen_view_model.dart';
import 'package:provider/provider.dart';

class FilterableScreen extends StatefulWidget {
  const FilterableScreen({super.key});

  @override
  State<FilterableScreen> createState() => _FilterableScreenState();
}

class _FilterableScreenState extends State<FilterableScreen> {
  @override
  Widget build(BuildContext context) {
    final filterableScreenViewModel =
        Provider.of<FilterableScreenViewModel>(context, listen: false);
    filterableScreenViewModel.discoverMoviesByFIlter(Filter.builder().build());

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: const Icon(Icons.filter),
            onTap: () {
              _displayBottomSheet(context);
            },
          ),
        ],
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Consumer<FilterableScreenViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.movieDiscovered) {
            case Success<List<Movie>>(data: var data):
              List<Movie> movies = data;
              //* Non ci sono film da mostrare
              if (movies.isEmpty) {
                return const Center(
                  child: Column(
                    children: [
                      Text(
                        'Seems empty here!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 20,
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 2,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return MediaPoster(
                        movie: movies[index],
                      );
                    });
              }
            //* Error
            case Error<List<Movie>>(message: var message):
              return Center(
                child: Text('Error: $message'),
              );
            //* Loading
            case Loading<List<Movie>>():
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

//TODO: Aggiungere le sezioni Sort By e Generi mostrando delle chips
Future _displayBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: MovieAppColors.primary,
    barrierColor: MovieAppColors.primary.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Sort by',
                style: MovieAppTextStyle.primaryPBold,
              ),
            )
          ],
        ),
      );
    },
  );
}
