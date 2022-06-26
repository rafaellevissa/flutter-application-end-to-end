import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');

  Future<T?> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    if (navigatorKey.currentState == null) {
      return null;
    }
    return navigatorKey.currentState!.push(pageRoute);
  }

  Future navigateToPageNamed(String pageName) async {
    if (navigatorKey.currentState == null) {
      return null;
    }
    return navigatorKey.currentState!.pushNamed(pageName);
  }

  Future<T?> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    if (navigatorKey.currentState == null) {
      return null;
    }
    return navigatorKey.currentState!.pushReplacement(pageRoute);
  }

  Future<T?> navigateToPageNamedWithReplacement<T>(String pageName) async {
    if (navigatorKey.currentState == null) {
      return null;
    }
    return navigatorKey.currentState!.pushReplacementNamed(pageName);
  }

  void pop<T>([T? result]) {
    if (navigatorKey.currentState == null) {
      return;
    }
    navigatorKey.currentState!.pop(result);
  }
}
