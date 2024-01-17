import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/network/network_state.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/texts.dart';
import '../../../domain/model/filter/sort_type.dart';
import '../../../domain/model/genre/genre.dart';
import '../_base/base_widget.dart';
import 'filterable_screen_view_model.dart';

class FilterableScreen extends StatefulWidget {
  const FilterableScreen({super.key});

  @override
  State<FilterableScreen> createState() => _FilterableScreenState();
}

class _FilterableScreenState extends State<FilterableScreen> {
  @override
  Widget build(BuildContext context) {
    final filterableViewModel = Provider.of<FilterableScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _displayBottomSheet(
                context,
                filterableViewModel,
              );
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
      body: BaseWidget<FilterableScreenViewModel>(
        viewModel: filterableViewModel,
        onModelReady: (FilterableScreenViewModel viewModel) {},
        builder: (context, viewModel, _) {
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
                          height: 140,
                          width: 120,
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
  FilterableScreenViewModel viewModel,
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
        return BaseWidget<FilterableScreenViewModel>(
            viewModel: viewModel,
            onModelReady: (FilterableScreenViewModel viewModel) {},
            builder: (context, viewModel, _) {
              return StatefulBuilder(builder: (context, state) {
                SortOptions selectedSortBy = viewModel.selectedSortOption;
                Set<Genre> selectedGenres = viewModel.selectedGenres;
                return Stack(
                  children: [
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Sort by',
                              style: MovieAppTextStyle.primaryPBold,
                            ),
                          ),
                        ),
                        _buildSortByChipGroup(selectedSortBy, viewModel),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildActionableHeader(
                            title: 'With Genre',
                            onActionSelected: () {
                              viewModel.clearGenreSelection();
                            },
                            isActionVisible: selectedGenres.isNotEmpty,
                          ),
                        ),
                        _buildGenresChipGroup(selectedGenres, viewModel),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MovieAppColors
                                    .primary, // Colore dello sfondo
                              ),
                              child: Text(
                                'Clear filters',
                                style: MovieAppTextStyle.secondaryPBold
                                    .copyWith(color: MovieAppColors.onPrimary),
                              ),
                              onPressed: () {
                                viewModel.clearFilter();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MovieAppColors
                                    .accent, // Colore dello sfondo
                              ),
                              child: Text(
                                'Apply filters',
                                style: MovieAppTextStyle.secondaryPBold
                                    .copyWith(color: MovieAppColors.onPrimary),
                              ),
                              onPressed: () {
                                viewModel.applyFilter();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
            });
      });
}

Widget _buildActionableHeader({
  bool isActionVisible = true,
  required String title,
  required Function onActionSelected,
}) {
  return Row(
    children: [
      Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: MovieAppTextStyle.primaryPBold,
          ),
        ),
      ),
      AnimatedOpacity(
        opacity: isActionVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: IconButton(
          onPressed: () {
            onActionSelected();
          },
          icon: const Icon(
            Icons.delete,
            color: MovieAppColors.accent,
          ),
        ),
      ),
    ],
  );
}

Wrap _buildSortByChipGroup(
  SortOptions selectedSortBy,
  FilterableScreenViewModel viewModel,
) {
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
      return SizedBox(
        height: 100,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: 1 / 2,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            Genre genre = data[index];
            return FilterChip(
              label: Text(genre.name),
              selected: selectedGenres.contains(genre),
              onSelected: (isSelected) {
                if (isSelected) {
                  viewModel.selectGenre(genre);
                } else {
                  viewModel.removeGenre(genre);
                }
              },
            );
          },
        ),
      );
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
