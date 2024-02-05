
import 'package:movie_app/core/network/exception/api_exception.dart';

/// Una classe sigillata che rappresenta diversi stati di una risposta, comunemente utilizzata nelle operazioni asincrone.
///
/// La classe [ResponseState] è sigillata, il che significa che ha un insieme limitato di sottoclassi (Success, Error, Loading).
/// Questo consente una gestione più esaustiva degli stati di risposta.
/// I generici vengono utilizzati per specificare il tipo di dati associato agli stati Success e Error.
/// Per lo stato Loading, non sono associati dati aggiuntivi.
sealed class ResultState<T> {}

/// Rappresenta uno stato di risposta di successo con dati associati.
class Success<T> extends ResultState<T> {
  /// I dati associati a una risposta di successo.
  final T data;

  Success({
    required this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() {
    return 'Success (data: $data)';
  }
}

/// Rappresenta uno stato di risposta di errore con un messaggio di errore associato.
class Error<T> extends ResultState<T> {
  /// Il messaggio di errore associato alla risposta.
  final String message;

  /// Un'istanza opzionale di [ApiException] contenente dettagli aggiuntivi sull'errore.
  final ApiException? exception;

  Error({required this.message, this.exception});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          exception == other.exception;

  @override
  int get hashCode => message.hashCode ^ exception.hashCode;

  @override
  String toString() {
    return 'Error (errorMessage: $message, exception: $exception)';
  }
}

/// Rappresenta uno stato di risposta di caricamento.
class Loading<T> extends ResultState<T> {
  ///Messaggio d'errore opzionale in fase di caricamento
  final String? message;

  Loading({this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Loading &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
  
  @override
  String toString() => 'Loading...';
}
