enum SortOptions {
  popularity(sortName: 'popularity', name: 'Popularity'),
  voteAverage(sortName: 'vote_average', name: 'Vote Average'),
  revenue(sortName: 'revenue', name: 'Revenue');

  final String sortName;
  final String name;

  const SortOptions({required this.sortName, required this.name});
}
