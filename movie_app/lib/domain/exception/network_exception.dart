// ignore_for_file: public_member_api_docs, sort_constructors_first
class NetworkException implements Exception {
  final int statusCode;
  String? message;
  NetworkException({
    required this.statusCode,
    this.message,
  });

  @override
  String toString() => 'NetworkException(statusCode: $statusCode, message: $message)';
}
