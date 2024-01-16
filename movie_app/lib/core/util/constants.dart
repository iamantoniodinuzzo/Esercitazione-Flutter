import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class Constants {
  const Constants._();
  static const connectTimeout = 5000;
  static const receiveTimeout = 5000;
}
