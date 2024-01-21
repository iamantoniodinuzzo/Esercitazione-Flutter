abstract class SearchMediaEvent {
  const SearchMediaEvent();
}

class GetSearchMedia extends SearchMediaEvent {
  final String? query;
  const GetSearchMedia(this.query);
}
