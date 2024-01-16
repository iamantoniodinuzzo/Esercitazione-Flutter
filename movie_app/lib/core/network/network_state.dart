// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class NetworkState<T> {}

class Success<T> extends NetworkState<T> {
  final T data;
  Success({
    required this.data,
  });
}

class Error<T> extends NetworkState<T> {
  final String message;

  Error({required this.message});
}

class Loading<T> extends NetworkState<T> {}
