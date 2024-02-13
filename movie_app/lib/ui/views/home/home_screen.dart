import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/theme/movie_app_dimensions.dart';
import 'package:movie_app/core/theme/movie_app_text_style.dart';
import 'package:movie_app/di/injection_container.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/home/trending_bloc/trending_movie_bloc.dart';
import 'package:movie_app/ui/views/home/trending_bloc/trending_movie_event.dart';
import 'package:movie_app/ui/views/home/trending_bloc/trending_movie_state.dart';
import 'package:movie_app/ui/views/search/search_screen.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';

import '../../../core/theme/movie_app_colors.dart';

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
    return BlocProvider(
      create: (context) => getIt<TrendingMovieBloc>()..add(GetTrendingMovies()),
      child: Scaffold(
        backgroundColor: MovieAppColors.secondary,
        body: BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
          builder: (_, state) {
            switch (state) {
              case TrendingMoviesLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TrendingMoviesLoaded():
                return Column(
                  children: [
                    //* Search bar
                    const SizedBox(
                      height: MovieAppDimensions.mediumPadding,
                    ),
                    _buildSearchBar(onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchScreen(),
                      );
                    }),
                    //* Carousel title
                    const SizedBox(
                      height: MovieAppDimensions.mediumPadding,
                    ),
                    const Text(
                      'Trending Movies',
                      style: MovieAppTextStyle.bigTitle,
                    ),
                    //* Trending Carousel
                    const SizedBox(
                      height: MovieAppDimensions.largePadding,
                    ),
                    _buildMediaCarousel(state.trendingMovies),
                  ],
                );
              case TrendingMoviesError():
                return Center(
                  child: Text('Error: ${state.errorMessage}'),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar({required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: MovieAppDimensions.basePadding,
        right: MovieAppDimensions.basePadding,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(
            horizontal: MovieAppDimensions.mediumPadding,
            vertical: MovieAppDimensions.mediumPadding,
          ),
          backgroundColor: MovieAppColors.primaryVariant,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color:
                    MovieAppColors.primary), // Imposta il colore del contorno
            borderRadius: BorderRadius.circular(
              MovieAppDimensions.roundedCornerRadius,
            ),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: MovieAppDimensions.basePadding),
            Text(
              "Search movies...",
              style: MovieAppTextStyle.body,
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
          style: MovieAppTextStyle.mediumTitle,
        ),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            MediaPoster.big(
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
