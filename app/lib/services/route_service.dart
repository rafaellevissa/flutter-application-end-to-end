import 'package:dqrtech/cities/ui/dqrtech_cities_view.dart';
import 'package:dqrtech/components/google_maps/ui/dqrtech_google_maps_view.dart';
import 'package:dqrtech/countries/ui/dqrtech_countries_view.dart';
import 'package:dqrtech/home/ui/dqrtech_home_view.dart';
import 'package:dqrtech/login/ui/dqrtech_login_view.dart';
import 'package:dqrtech/routes.dart';
import 'package:flutter/material.dart';

class DqrtechRouteService {
  DqrtechRouteService() {
    registerRoutes();
  }

  Map<String, WidgetBuilder>? _routes;

  void registerRoutes() {
    _routes = {
      Routes.HOME: (context) => const DqrtechHomeView(),
      Routes.COUNTRIES: (context) => const DqrtechCountriesView(),
      Routes.CITIES: (context) => const DqrtechCitiesView(),
      Routes.LOGIN: (context) => const DqrtechLoginView(),
      Routes.GOOGLE_MAPS: (context) => const DqrtechGoogleMapsView()
    };
  }

  get routes => _routes;
}
