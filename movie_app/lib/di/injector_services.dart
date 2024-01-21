import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/data/remote/service/movie_service.dart';
import 'package:riverpod/riverpod.dart';


final dioClientProvider = Provider<DioClient>((ref){
  const apiKey = '';//FIXME: COme inserire l'api key?
  return DioClient(apiKey: apiKey);
});

final movieServiceProvider = Provider<MovieService>((ref){
  final apiClient = ref.read(dioClientProvider);
  return MovieService(apiClient: apiClient);
});