enum SortOptions {
  popularity(sortName: 'popularity'),
  voteAverage(sortName: 'vote_average'),
  revenue(sortName: 'revenue');

  final String sortName;

  const SortOptions({required this.sortName});
}
