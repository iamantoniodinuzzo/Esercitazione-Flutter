import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/theme/movie_app_text_style.dart';
import 'package:movie_app/di/injection_container.dart';
import 'package:movie_app/ui/views/search/bloc/search_media_bloc.dart';
import 'package:movie_app/ui/views/search/bloc/search_media_event.dart';
import 'package:movie_app/ui/views/search/bloc/search_media_state.dart';
import 'package:movie_app/ui/widgets/generic_widgets/media_vertical_list.dart';

class SearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchMovie(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchMovie(context);
  }

  Widget _searchMovie(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchMediaBloc>()..add(GetSearchMedia(query)),
      child:
          BlocBuilder<SearchMediaBloc, SearchMediaState>(builder: (_, state) {
        switch (state) {
          //* Success
          case SearchMediaLoaded(result: var data):
            return MediaVerticalList(
              movies: data,
            );
          //* Error
          case SearchMediaError(errorMessage: var message):
            return Center(
              child: Text('Error: $message'),
            );

          //*Loading
          case SearchMediaLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SearchMediaInitial():
            return const Center(
              child: Text(
                'Seems empty here, search some movies',
                style: MovieAppTextStyle.secondaryPRegular,
              ),
            );
        }
      }),
    );
  }
}
