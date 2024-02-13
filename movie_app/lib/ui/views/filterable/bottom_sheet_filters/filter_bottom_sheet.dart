import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/movie_app_colors.dart';
import 'package:movie_app/core/theme/movie_app_text_style.dart';
import 'package:movie_app/domain/model/genre/genre.dart';
import 'package:movie_app/ui/views/filterable/bottom_sheet_filters/bloc/filter_bloc.dart';

Future displayBottomSheet(
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
                  // _buildSortByChipGroup(selectedSortBy, viewModel),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildActionableHeader(
                      title: 'With Genre',
                      onActionSelected: () {
                        // viewModel.clearGenreSelection();
                        //TODO: Pulire la selezione dei generi
                      },
                      isActionVisible: true,
                    ),
                  ),
                  _buildGenresChipGroup(),
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
                          backgroundColor:
                              MovieAppColors.primary, // Colore dello sfondo
                        ),
                        child: Text(
                          'Clear filters',
                          style: MovieAppTextStyle.secondaryPBold
                              .copyWith(color: MovieAppColors.onPrimary),
                        ),
                        onPressed: () {
                          context.read<FilterBloc>().add(
                                ClearFilter(),
                              );
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              MovieAppColors.accent, // Colore dello sfondo
                        ),
                        child: Text(
                          'Apply filters',
                          style: MovieAppTextStyle.secondaryPBold
                              .copyWith(color: MovieAppColors.onPrimary),
                        ),
                        onPressed: () {
                          //FIXME: Come passare un filtro?
                       /*   context
                              .read<FilterBloc>()
                              .add(ApplyFilter(filter: filter));*/
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

Widget _buildGenresChipGroup() {
  return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
    if (state.status.isGenreLoaded) {
      var movieGenres = state.movieGenres;
      var selectedGenres = state.selectedGenres;
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
          itemCount: movieGenres.length,
          itemBuilder: (BuildContext context, int index) {
            final Genre genre = movieGenres[index];
            return FilterChip(
              label: Text(genre.name),
              selected: selectedGenres.contains(genre),
              onSelected: (isSelected) {
                if (isSelected) {
                  context.read<FilterBloc>().add(
                        SelectGenre(selectedGenre: genre),
                      );
                } else {
                  context.read<FilterBloc>().add(
                        DeselectGenre(deselectedGenre: genre),
                      );
                }
              },
            );
          },
        ),
      );
    }
    if (state.status.isGenreError) {
      return Center(
        child: Text(state.errorMessage),
      );
    }
    if (state.status.isGenreLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container();
  });
}
