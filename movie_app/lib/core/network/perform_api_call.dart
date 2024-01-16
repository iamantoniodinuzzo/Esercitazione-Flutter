import 'package:dio/dio.dart';
import 'package:movie_app/core/exception/server_exception_type.dart';
import 'package:movie_app/util/extensions/extensions.dart';


/// Esegue una chiamata API generica.
///
/// [apiCall] è la funzione che rappresenta la chiamata API.
/// [fromJson] è la funzione di deserializzazione da JSON all'oggetto desiderato.
Future<T> performApiCall<T>(
  Future<Response> Function() apiCall,
  T Function(Map<String, dynamic> json) fromJson,
) async {
  try {
    final response = await apiCall();
    if (response.succeeded()) {
      return fromJson(response.data);
    } else {
      throw ServerException(response);
    }
  } on DioException catch (error) {
    throw ServerException(error);
  }
}

