import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/ui/theme/colors.dart';
import 'package:movie_app/ui/theme/texts.dart';
import 'package:movie_app/ui/views/_base/base_view_widget_state.dart';
import 'package:movie_app/ui/views/filterable/filterable_media_contract.dart';
import 'package:movie_app/ui/views/filterable/filterable_screen_view_model.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/filter/sort_type.dart';
import '../../../domain/models/genre/genre.dart';

class FilterableMediaView extends StatefulWidget {
  const FilterableMediaView({super.key});

  @override
  State<FilterableMediaView> createState() => _FilterableMediaViewState();
}

class _FilterableMediaViewState extends BaseViewWidgetState<
    FilterableMediaView,
    FilterableMediaVMContract,
    FilterableMediaVMState> implements FilterableMediaViewContract {
  @override
  bool get autoSubscribeToVmStateChanges => false;

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.filter),
            onPressed: () {
              showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  backgroundColor: MovieAppColors.primary.withOpacity(0.5),
                  barrierColor: MovieAppColors.primary.withOpacity(0.5),
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    side: BorderSide(color: MovieAppColors.primary, width: 2),
                  ),
                  builder: (context) {
                    return StatefulBuilder(builder: (context, state) {
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
                              viewSelectorWidget(
                                builder: (context) {
                                  return _buildSortByChipGroup(
                                    vmState.selectedSortBy,
                                    vmContract,
                                  );
                                },
                                selector: (vmState) => vmState.selectedSortBy,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildActionableHeader(
                                  title: 'With Genre',
                                  onActionSelected: () {
                                    vmContract.onClearGenreSelection();
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
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, right: 10),
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
                                          .copyWith(
                                              color: MovieAppColors.onPrimary),
                                    ),
                                    onPressed: () {
                                      vmContract.onClearFilter();
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
                                          .copyWith(
                                              color: MovieAppColors.onPrimary),
                                    ),
                                    onPressed: () {
                                      vmContract.onApplyFilter();
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
      body: viewSelectorWidget(
          builder: (context) {
            switch (vmState.filteredMovies) {
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
          selector: (vmState) => vmState.filteredMovies),
    );
  }

  @override
  void onInitState() {
    // TODO: implement onInitState
  }
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
  FilterableMediaVMContract vmContract,
) {
  return Wrap(
    spacing: 8.0,
    children: SortOptions.values.map((sortOption) {
      return FilterChip(
        label: Text(sortOption.name),
        selected: selectedSortBy == sortOption,
        onSelected: (isSelected) {
          vmContract.onSelectSortOptions(sortOption);
        },
      );
    }).toList(),
  );
}

Widget _buildGenresChipGroup(
  Set<Genre> selectedGenres,
  List<Genre> movieGenres,
  FilterableMediaVMContract vmContract,
) {
  switch (movieGenres) {
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
                  vmContract.onSelectGenre(genre);
                } else {
                  vmContract.onRemoveGenre(genre);
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
