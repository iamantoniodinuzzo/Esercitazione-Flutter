import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/network/network_state.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/_base/base_widget.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';

import '../../../core/theme/colors.dart';
import 'home_view_model.dart';

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
      body: BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelReady: (HomeViewModel viewModel) =>
            viewModel.fetchTrendingMovies(),
        builder: (context, viewModel, _) {
          switch (viewModel.trendingMovies) {
            //*Success
            case Success<List<Movie>>(data: var data):
              return _buildMediaCarousel(data);
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

  Widget _buildMediaCarousel(List<Movie> data) {
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
      return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            MediaPoster(
          movie: data[itemIndex],
          onTap: () {
            context.pushNamed(
              AppRoutes.details.name,
              extra: data[itemIndex],
            );
          },
        ),
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.5,
          viewportFraction: 0.4,
          scrollDirection: Axis.horizontal,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 10),
          reverse: false,
          initialPage: 0,
        ),
      );
    }
  }
}
