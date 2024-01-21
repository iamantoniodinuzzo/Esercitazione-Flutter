// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Incapsula il risultato di una chiamata API
sealed class ResultState<T> {}

class Success<T> extends ResultState<T> {
  final T data;

  Success({
    required this.data,
  });
}

class Error<T> extends ResultState<T> {
  final String message;

  Error({required this.message});
}

class Loading<T> extends ResultState<T> {}

