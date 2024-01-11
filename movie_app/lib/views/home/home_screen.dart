import 'package:flutter/material.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:movie_app/views/home/home_view_model.dart';
import 'package:movie_app/views/search/search_screen.dart';
import 'package:provider/provider.dart';

import '../../res/components/media_vertical_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieAppColors.secondary,
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.trendingMovies) {
            //*Success
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
                return MediaVerticalList(movies: movies);
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
