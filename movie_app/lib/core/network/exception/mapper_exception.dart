// ignore_for_file: public_member_api_docs, sort_constructors_first
class MapperException<From, To> implements Exception {
  final String message;
  MapperException({
    required this.message,
  });

  
  @override
  String toString() => 'Error when mapping class $From to $To: $message';
}
