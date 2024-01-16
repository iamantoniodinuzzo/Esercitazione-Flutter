import 'package:get_it/get_it.dart';
import 'package:movie_app/di/locator_repositories.dart';
import 'package:movie_app/di/locator_services.dart';

final getIt = GetIt.instance;
bool _initialized = false;

void serviceLocatorInitialization() async {
  if (!_initialized) {
    await initializeServices();
    initializeRepositories();
    _initialized = true;
  }
}
