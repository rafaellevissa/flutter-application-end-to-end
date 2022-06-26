import 'service_locator.dart';

class DependencyBase {
  static DependencyResolver resolverInstance = DependencyResolver();

  static void registerSingleton<T extends Object>(T instance) {
    resolverInstance.registerSingleton<T>(instance);
  }

  static void registerLazySingleton<T extends Object>(T Function() builder) {
    resolverInstance.registerLazySingleton<T>(builder);
  }

  static void registerFactory<T extends Object>(T Function() builder) {
    resolverInstance.registerFactory<T>(builder);
  }

  static T resolve<T extends Object>(Object model) {
    return resolverInstance.resolve<T>(model);
  }

  static T createNewInstance<T extends Object>(Object model) {
    return resolverInstance.createNewInstance<T>(model);
  }
}

class DependencyResolver {
  DependencyResolver();
  void setupServiceLocator() {
    setupLocator();
  }

  void registerSingleton<T extends Object>(T instance) {
    locator.registerSingleton<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T Function() builder) {
    locator.registerLazySingleton<T>(builder);
  }

  void registerFactory<T extends Object>(T Function() builder) {
    locator.registerFactory<T>(builder);
  }

  T resolve<T extends Object>(Object model) {
    return locator<T>();
  }

  T createNewInstance<T extends Object>(Object model) {
    return locator.get<T>();
  }
}
