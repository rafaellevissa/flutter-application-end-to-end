import 'dart:convert';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/core/shell/dqrtech_base_app_model.dart';
import 'package:dqrtech/services/authentication_service.dart';
import 'package:dqrtech/services/firestore_service.dart';
import 'package:dqrtech/services/media_query_service.dart';
import 'package:dqrtech/services/navigator_service.dart';
import 'package:dqrtech/services/route_service.dart';

class ShellService {
  ShellService();

  Future<void> initApplication() async {
    setupDrqtechLocators();
  }

  void setupDrqtechLocators() {
    setupAppLocator();
  }

  void setupAppLocator() {
    registerSingletons();
    registerFactories();
  }

  void registerSingletons() {
    DependencyBase.registerLazySingleton(() => DqrtechBaseAppModel());
    DependencyBase.registerSingleton<NavigatorService>(NavigatorService());
    DependencyBase.registerSingleton<MediaQueryService>(MediaQueryService());
    DependencyBase.registerLazySingleton(() => FirestoreService());
    DependencyBase.registerLazySingleton(() => AuthenticationService());
  }

  void registerFactories() {
    DependencyBase.registerFactory<DqrtechRouteService>(() => DqrtechRouteService());
  }
}
