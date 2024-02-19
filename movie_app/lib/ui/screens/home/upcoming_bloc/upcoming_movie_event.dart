import 'package:equatable/equatable.dart';

abstract class UpcomingMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUpcomingMovies extends UpcomingMovieEvent {}
