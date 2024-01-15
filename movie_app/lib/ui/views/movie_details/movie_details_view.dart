import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/models/movie/movie.dart';
import 'package:movie_app/domain/models/movie/movie_details.dart';
import 'package:movie_app/ui/views/_base/base_view_widget_state.dart';
import 'package:movie_app/ui/views/movie_details/movie_details_contract.dart';
import 'package:movie_app/ui/widgets/model_widgets/media_poster.dart';
import 'package:movie_app/ui/theme/colors.dart';
import 'package:movie_app/ui/theme/texts.dart';
import 'package:movie_app/util/user_interface_state.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key, required this.selectedMedia});

  final Movie selectedMedia;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends BaseViewWidgetState<
    MovieDetailView,
    MovieDetailsVMContract,
    MovieDetailsVMState> implements MovieDetailsViewContract {
  // Questa variabile permette di visualizzare il titolo quando l'app bar collassa
  var appBarHeight = 0.0;

  @override
  bool get autoSubscribeToVmStateChanges => false;

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
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
                            imageUrl: widget
                                .selectedMedia.completeBackdropPathOriginal,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
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
                                child: MediaPoster(
                                  movie: widget.selectedMedia,
                                  isVoteAverageVisible: false,
                                ),
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
          body: viewSelectorWidget(
            selector: (vmState) => vmState.movieDetails,
            builder: (context) {
              switch (vmState.movieDetails) {
                //* Success
                case Success<MovieDetails>(data: var data):
                  MovieDetails? movieDetails = data;
                  return _buildMovieDetailsContent(movieDetails);
                case Error<MovieDetails>(message: var message):
                  //TODO: Generalizzare questo widget che mostra un errore
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Error movieId(${widget.selectedMedia.id}): $message',
                      ),
                    ),
                  );
                case Loading<MovieDetails>():
                  //TODO: Generalizzare in un widget che mostra il caricamento
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildMovieDetailsContent(MovieDetails movieDetails) {
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
            _buildHorizontalSectionInfo(
              title: 'Original title',
              value: movieDetails.originalTitle,
            ),
            _buildHorizontalSectionInfo(
              title: 'Release date',
              value: movieDetails.releaseDate,
            ),
            _buildHorizontalSectionInfo(
              title: 'Budget',
              value: movieDetails.budget.toString(),
              isVisibleWhen: () => movieDetails.budget != 0,
            ),
            _buildHorizontalSectionInfo(
              title: 'Revenue',
              value: movieDetails.revenue.toString(),
              isVisibleWhen: () => movieDetails.revenue != 0,
            ),
            _buildHorizontalSectionInfo(
              title: 'Runtime',
              value: movieDetails.runtime.toString(),
            ),
            _buildHorizontalSectionInfo(
              title: 'Original language',
              value: movieDetails.originalLanguage,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInitState() {
    vmContract.getMovieDetails(widget.selectedMedia.id);
  }



}

/// Mostra una sezione orizzontale caratterizzata da un titolo e un valore
/// nascondendola quando [isVisibleWhen] non rispetta la logica fornita
Widget _buildHorizontalSectionInfo({
  required String title,
  required String value,
  bool Function()? isVisibleWhen,
}) {
  return Visibility(
    visible: isVisibleWhen?.call() ?? true,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
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
            value,
            overflow: TextOverflow.clip,
            style: MovieAppTextStyle.secondaryPBold,
          ),
        )
      ],
    ),
  );
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
