import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/core/theme/texts.dart';
import 'package:movie_app/di/injection_container.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/ui/views/home/bloc/trending_movie_bloc.dart';
import 'package:movie_app/ui/views/home/bloc/trending_movie_event.dart';
import 'package:movie_app/ui/views/home/bloc/trending_movie_state.dart';
import 'package:movie_app/ui/views/search/search_screen.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';

import '../../../core/theme/colors.dart';

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
                    _buildMediaCarousel(state.trendingMovies ?? List.empty()),
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
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          backgroundColor: MovieAppColors.primaryVariant,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color:
                    MovieAppColors.primary), // Imposta il colore del contorno
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
