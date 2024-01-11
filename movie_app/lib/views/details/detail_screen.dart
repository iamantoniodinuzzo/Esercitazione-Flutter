import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/model/movie/movie.dart';
import 'package:movie_app/domain/model/movie/movie_details.dart';
import 'package:movie_app/res/components/media_poster.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/theme/texts.dart';
import 'package:movie_app/util/user_interface_state.dart';
import 'package:movie_app/views/details/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.selectedMedia});

  final Movie selectedMedia;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Questa variabile permette di visualizzare il titolo quando l'app bar collassa
  var appBarHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final detailViewModel =
        Provider.of<DetailViewModel>(context, listen: false);

    detailViewModel.getMovieDetails(widget.selectedMedia.id);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: MovieAppColors.primary,
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back),
                onTap: () {
                  context.pop();
                },
              ),
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                appBarHeight = constraints.biggest.height;
                return FlexibleSpaceBar(
                  //* Titolo visibile solo se app bar collassata
                  title: _CollapsedTitle(
                    appBarHeight: appBarHeight,
                    title: widget.selectedMedia.title,
                  ),
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // * Immagine di sfondo
                      Positioned.fill(
                        bottom: 100,
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    MovieAppColors.primary.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          imageUrl:
                              widget.selectedMedia.completeBackdropPathOriginal,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                      // * Contenuto sovrapposto
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // * Poster
                            Hero(
                              tag: widget.selectedMedia.id,
                              child: MediaPoster(movie: widget.selectedMedia),
                            ),
                            const SizedBox(width: 16.0),
                            //* Titolo
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                widget.selectedMedia.title,
                                style: MovieAppTextStyle.secondaryH1Bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
        body: Consumer<DetailViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.movieDetails) {
              //* Success
              case Success<MovieDetails>(data: var data):
                MovieDetails? movieDetails = data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetails.tagline,
                          style: MovieAppTextStyle.secondaryPBold,
                        ),
                        Text(movieDetails.overview),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Genres',
                          style: MovieAppTextStyle.secondaryPBold,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: (movieDetails.genres)
                              .map(
                                (genre) => Chip(
                                  label: Text(genre.name),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Information',
                          style: MovieAppTextStyle.secondaryPBold,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _HorizontalSectionInfo(
                          title: 'Original title',
                          value: movieDetails.originalTitle,
                        ),
                        _HorizontalSectionInfo(
                          title: 'Release date',
                          value: movieDetails.releaseDate,
                        ),
                        _HorizontalSectionInfo(
                          title: 'Budget',
                          value: movieDetails.budget.toString(),
                          isVisibleWhen: () => movieDetails.budget != 0,
                        ),
                        _HorizontalSectionInfo(
                          title: 'Revenue',
                          value: movieDetails.revenue.toString(),
                          isVisibleWhen: () => movieDetails.revenue != 0,
                        ),
                        _HorizontalSectionInfo(
                          title: 'Runtime',
                          value: movieDetails.runtime.toString(),
                        ),
                        _HorizontalSectionInfo(
                          title: 'Original language',
                          value: movieDetails.originalLanguage,
                        ),
                      ],
                    ),
                  ),
                );
              case Error<MovieDetails>(message: var message):
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Error movieId(${widget.selectedMedia.id}): $message',
                    ),
                  ),
                );
              case Loading<MovieDetails>():
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}

/// Mostra una sezione orizzontale caratterizzata da un titolo e un valore
class _HorizontalSectionInfo extends StatelessWidget {
  final String _title;
  final String _value;
  final bool Function()? _isVisibleWhen;

  const _HorizontalSectionInfo({
    required String title,
    required String value,
    bool Function()? isVisibleWhen,
  })  : _title = title,
        _value = value,
        _isVisibleWhen = isVisibleWhen;

  bool get isVisible => _isVisibleWhen?.call() ?? true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:  isVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _title,
              style: MovieAppTextStyle.secondaryPRegular,
              textAlign: TextAlign.left,
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.left,
              _value,
              overflow: TextOverflow.clip,
              style: MovieAppTextStyle.secondaryPBold,
            ),
          )
        ],
      ),
    );
  }
}

///Mostra il titolo nella App bar
///solo quando l'altezza della sliver app bar raggiunge quella della toolbar più quella della status
class _CollapsedTitle extends StatelessWidget {
  const _CollapsedTitle({
    required this.appBarHeight,
    required this.title,
  });

  final double appBarHeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity:
          appBarHeight == MediaQuery.of(context).padding.top + kToolbarHeight
              ? 1.0
              : 0.0,
      child: Text(
        title,
        style: MovieAppTextStyle.secondaryPBold,
      ),
    );
  }
}
