import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/routes.dart';
import 'package:dqrtech/services/analytics_service.dart';
import 'package:dqrtech/services/authentication_service.dart';
import 'package:dqrtech/services/firestore_service.dart';
import 'package:dqrtech/services/navigator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DqrtechCountriesViewModel extends BaseModel {
  List<CountryModel> _countries = [];
  List<CountryModel> get countries => _countries;

  final String countriesText = "Countries";

  DqrtechCountriesViewModel() {
    getCountries();
  }

  getCountries() {
    var firestoreService =
        DependencyBase.resolve<FirestoreService>(FirestoreService);
    firestoreService.getCountries().then((snapshot) {
      List<CountryModel> data = [];
      for (var doc in snapshot.docs) {
        data.add(
          CountryModel(doc.id, doc.get('name')),
        );
      }
      _countries = data;
      notifyListeners();
    });
  }

  doNavigateToCities(CountryModel country) async {
    await AnalyticsService().country(country);

    var navigatorService =
        DependencyBase.resolve<NavigatorService>(NavigatorService);
    navigatorService.navigatorKey.currentState?.pushNamed(
      Routes.CITIES,
      arguments: {
        'countryId': country.id,
      },
    );
  }

  doLogout() {
    var authenticationService =
        DependencyBase.resolve<AuthenticationService>(AuthenticationService);
    authenticationService.doLogout();
  }
}

class CountryModel {
  final String id;
  final String name;

  CountryModel(this.id, this.name);
}
