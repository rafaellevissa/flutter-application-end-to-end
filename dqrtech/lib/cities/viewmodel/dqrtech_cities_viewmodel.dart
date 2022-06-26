import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/routes.dart';
import 'package:dqrtech/services/analytics_service.dart';
import 'package:dqrtech/services/authentication_service.dart';
import 'package:dqrtech/services/firestore_service.dart';
import 'package:dqrtech/services/navigator_service.dart';

class DqrtechCitiesViewModel extends BaseModel {
  List<CityModel> _cities = [];
  List<CityModel> get cities => _cities;

  final String citiesText = "Cities";

  DqrtechCitiesViewModel(String countryId) {
    getCities(countryId);
  }

  getCities(String countryId) {
    var firestoreService = DependencyBase.resolve<FirestoreService>(FirestoreService);
    firestoreService.getCities(countryId).then((snapshot) {
      List<CityModel> data = [];
      for (var doc in snapshot.docs) {
        data.add(
          CityModel(doc.id, doc.get('name'), doc.get('country'), doc.get('subcountry'), doc.get('geonameid')),
        );
      }
      _cities = data;
      notifyListeners();
    });
  }

  doNavigateToGoogleMaps(CityModel city) async {
    await AnalyticsService().city(city);

    var navigatorService = DependencyBase.resolve<NavigatorService>(NavigatorService);
    navigatorService.navigatorKey.currentState?.pushNamed(
      Routes.GOOGLE_MAPS,
      arguments: {'country': city.country, 'subcountry': city.subCountry, 'city': city.name},
    );
  }

  doLogout() {
    var authenticationService = DependencyBase.resolve<AuthenticationService>(AuthenticationService);
    authenticationService.doLogout();
  }
}

class CityModel {
  final String id;
  final String name;
  final String country;
  final String subCountry;
  final String geoNameId;

  CityModel(this.id, this.name, this.country, this.subCountry, this.geoNameId);
}
