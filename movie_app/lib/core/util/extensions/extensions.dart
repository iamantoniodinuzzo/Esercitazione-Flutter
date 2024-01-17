import 'package:dio/dio.dart';

extension Succeded on Response {
  bool succeeded() {
    return statusCode != null && statusCode! == 200;
  }
}
