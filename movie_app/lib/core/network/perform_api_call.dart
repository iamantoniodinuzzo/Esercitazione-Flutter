import 'package:dio/dio.dart';
import 'package:movie_app/core/network/exception/api_exception.dart';
import 'package:movie_app/core/util/extensions/extensions.dart';

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
      throw ApiException(response);
    }
  } on DioException catch (error) {
    throw ApiException(error);
  }
}
