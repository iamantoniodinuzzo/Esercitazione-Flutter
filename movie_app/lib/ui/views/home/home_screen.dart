import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/network/result_state.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/theme/texts.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/_base/base_widget.dart';
import 'package:movie_app/ui/views/search/search_screen.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';
import 'package:provider/provider.dart';

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
    final  homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      backgroundColor: MovieAppColors.secondary,
      body: BaseWidget<HomeViewModel>(
        viewModel: homeViewModel,
        onModelReady: (HomeViewModel viewModel) =>
            viewModel.fetchTrendingMovies(),
        builder: (context, viewModel, _) {
          switch (viewModel.trendingMovies) {
            //*Success
            case Success<List<Movie>>(data: var data):
              return Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  _buildSearchBar(onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchScreen(),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildMediaCarousel(data),
                ],
              );
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

  Widget _buildSearchBar({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          backgroundColor: MovieAppColors.primaryVariant,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: MovieAppColors.primary), // Imposta il colore del contorno
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8.0),
            Text(
              "Search movies...",
              style: MovieAppTextStyle.primaryPRegular,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCarousel(List<Movie> data) {
    List<Movie> movies = data;
    //* Non ci sono film da mostrare
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'Seems empty here!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            MediaPoster(
              height: 140,
          width: 130,
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
          viewportFraction: 0.40,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          reverse: false,
          initialPage: 0,
        ),
      );
    }
  }
}
