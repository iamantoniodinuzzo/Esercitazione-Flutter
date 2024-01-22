import 'package:equatable/equatable.dart';

abstract class TrendingMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrendingMovies extends TrendingMovieEvent {}
