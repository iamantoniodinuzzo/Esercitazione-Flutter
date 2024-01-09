// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class UserInterfaceState<T> {}

class Success<T> extends UserInterfaceState<T> {
  final T data;
  Success({
    required this.data,
  });
}

class Error<T> extends UserInterfaceState<T> {
  final String message;

  Error({required this.message});
}

class Loading<T> extends UserInterfaceState<T> {}
