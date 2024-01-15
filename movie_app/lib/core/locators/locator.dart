import 'package:get_it/get_it.dart';
import 'package:movie_app/core/locators/locator_modules.dart';
import 'package:movie_app/core/locators/locator_repositories.dart';
import 'package:movie_app/core/locators/locator_screens.dart';

final getIt = GetIt.instance;
bool _initialized = false;

Future<void> serviceLocatorInitialization() async {
  if (!_initialized) {
    await initializeModules();
    initializeRepositories();
    initializeScreens();
    _initialized = true;
  }
}
