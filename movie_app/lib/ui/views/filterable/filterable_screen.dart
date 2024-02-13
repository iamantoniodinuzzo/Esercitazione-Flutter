import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/di/injection_container.dart';
import 'package:movie_app/domain/model/filter/filter.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_bloc.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_event.dart';
import 'package:movie_app/ui/views/filterable/bloc/discover_media_state.dart';

import '../../../core/theme/movie_app_colors.dart';
import '../../../core/theme/movie_app_text_style.dart';
import '../../../domain/model/filter/sort_type.dart';
import '../../../domain/model/genre/genre.dart';
import 'bottom_sheet_filters/filter_bottom_sheet.dart';

class FilterableScreen extends StatefulWidget {
  const FilterableScreen({super.key});

  @override
  State<FilterableScreen> createState() => _FilterableScreenState();
}

class _FilterableScreenState extends State<FilterableScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DiscoverMediaBloc>()
        ..add(
          GetMediaByFilter(filter: FilterBuilder().build()),
        ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                displayBottomSheet(context);
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
        body: BlocBuilder<DiscoverMediaBloc, DiscoverMediaState>(
          builder: (_, state) {
            return Container();
            // switch (state) {
            //   case FilteredMediaLoaded(filteredMedia: var movies!):
            //     //* Non ci sono film da mostrare
            //     if (movies.isEmpty) {
            //       return const Center(
            //         child: Column(
            //           children: [
            //             Text(
            //               'Seems empty here!',
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     } else {
            //       //* Mostro i film filtrati
            //       return Padding(
            //         padding: const EdgeInsets.all(10),
            //         child: GridView.builder(
            //             gridDelegate:
            //                 const SliverGridDelegateWithMaxCrossAxisExtent(
            //               mainAxisSpacing: 20,
            //               maxCrossAxisExtent: 150,
            //               crossAxisSpacing: 20,
            //               childAspectRatio: 1 / 2,
            //             ),
            //             itemCount: movies.length,
            //             itemBuilder: (context, index) {
            //               return MediaPoster(
            //                 height: 140,
            //                 width: 120,
            //                 movie: movies[index],
            //               );
            //             }),
            //       );
            //     }
            //   //* Error
            //   case FilteredMediaError(errorMessage: var message):
            //     return Center(
            //       child: Text('Error: $message'),
            //     );
            //   //* Loading
            //   case FilteredMediaLoading():
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            // }
          },
        ),
      ),
    );
  }
}





Wrap _buildSortByChipGroup(
  SortOptions selectedSortBy,
) {
  return Wrap(
    spacing: 8.0,
    children: SortOptions.values.map((sortOption) {
      return FilterChip(
        label: Text(sortOption.name),
        selected: selectedSortBy == sortOption,
        onSelected: (isSelected) {
          // selectedSortBy = sortOption;
          // viewModel.selectSortBy(sortOption);
        },
      );
    }).toList(),
  );
}


