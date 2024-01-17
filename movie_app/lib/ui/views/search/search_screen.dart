import 'package:flutter/material.dart';
import 'package:movie_app/core/network/network_state.dart';
import 'package:movie_app/core/theme/colors.dart';
import 'package:movie_app/core/theme/texts.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/search/search_view_model.dart';
import 'package:movie_app/ui/widgets/generic_widgets/media_vertical_list.dart';
import 'package:provider/provider.dart';

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
        Navigator.pop(context);
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

  Consumer<SearchViewModel> _searchMovie(BuildContext context) {

    return Consumer<SearchViewModel>(
        builder: (context, viewModel, _) {
          switch (viewModel.queryResult) {
            //* Success
            case Success<List<Movie>>(data: var data):
              List<Movie> medias = data;
              if (medias.isEmpty) {
                return const Center(
                  child: Text(
                    'Seems empty here, search some movies',
                    style: MovieAppTextStyle.secondaryPRegular,
                  ),
                );
              } else {
                return MediaVerticalList(
                  movies: medias,
                );
              }

            //* Error
            case Error<List<Movie>>(message: var message):
              return Center(
                child: Text('Error: $message'),
              );

            //*Loading
            case Loading<List<Movie>>():
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }
}
