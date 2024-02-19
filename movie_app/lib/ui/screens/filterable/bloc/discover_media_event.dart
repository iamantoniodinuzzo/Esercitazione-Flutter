import 'package:movie_app/domain/model/filter/filter.dart';

abstract class DiscoverMediaEvent {
  const DiscoverMediaEvent();
}

class GetMediaByFilter extends DiscoverMediaEvent {
  final Filter filter;

  GetMediaByFilter({required this.filter});
}
