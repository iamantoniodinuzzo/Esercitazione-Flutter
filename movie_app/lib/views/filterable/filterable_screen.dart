import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/theme/texts.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:movie_app/views/filterable/filterable_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../domain/model/filter/sort_type.dart';
import '../../domain/model/genre/genre.dart';

class FilterableScreen extends StatefulWidget {
  const FilterableScreen({super.key});

  @override
  State<FilterableScreen> createState() => _FilterableScreenState();
}

class _FilterableScreenState extends State<FilterableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.filter),
            onPressed: () {
              _displayBottomSheet(context);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
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
                //* Mostro i film filtrati
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
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
                      }),
                );
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

Future _displayBottomSheet(
  BuildContext context,
) {
  return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: MovieAppColors.primary.withOpacity(0.5),
      barrierColor: MovieAppColors.primary.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        side: BorderSide(color: MovieAppColors.primary, width: 2),
      ),
      builder: (context) {
        return Consumer<FilterableScreenViewModel>(
            builder: (context, viewModel, child) {
          return StatefulBuilder(builder: (context, state) {
            SortOptions selectedSortBy = viewModel.selectedSortOption;
            Set<Genre> selectedGenres = viewModel.selectedGenres;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sort by',
                      style: MovieAppTextStyle.primaryPBold,
                    ),
                  ),
                  _buildSortByChipGroup(selectedSortBy, viewModel),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'With Genres',
                      style: MovieAppTextStyle.primaryPBold,
                    ),
                  ),
                  _buildGenresChipGroup(selectedGenres, viewModel)
                ],
              ),
            );
          });
        });
      });
}

Wrap _buildSortByChipGroup(
    SortOptions selectedSortBy, FilterableScreenViewModel viewModel) {
  return Wrap(
    spacing: 8.0,
    children: SortOptions.values.map((sortOption) {
      return FilterChip(
        label: Text(sortOption.name),
        selected: selectedSortBy == sortOption,
        onSelected: (isSelected) {
          // selectedSortBy = sortOption;
          viewModel.selectSortBy(sortOption);
        },
      );
    }).toList(),
  );
}

Widget _buildGenresChipGroup(
    Set<Genre> selectedGenres, FilterableScreenViewModel viewModel) {
  switch (viewModel.movieGenres) {
    case Success<List<Genre>>(data: var data):
      return Wrap(
          spacing: 8.0,
          children: data.map((genre) {
            return FilterChip(
              label: Text(genre.name),
              selected: selectedGenres.contains(genre),
              onSelected: (isSelected) {
                //Se il genere risulta selezionato lo aggiungo alla collezione
                //altrimenti viene rimosso
                if (isSelected) {
                  // selectedGenres.add(genre);
                  viewModel.selectGenre(genre);
                } else {
                  //  selectedGenres.remove(genre);
                  viewModel.removeGenre(genre);
                }
              },
            );
          }).toList());
    case Error<List<Genre>>(message: var message):
      return Center(
        child: Text(message),
      );
    case Loading<List<Genre>>():
      return const Center(
        child: CircularProgressIndicator(),
      );
  }
}
