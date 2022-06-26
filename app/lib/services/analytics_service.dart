import 'package:dqrtech/cities/viewmodel/dqrtech_cities_viewmodel.dart';
import 'package:dqrtech/countries/viewmodel/dqrtech_countries_viewmodel.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> country(CountryModel country) {
    AnalyticsEventItem analyticsItem = AnalyticsEventItem(
        quantity: 1,
        itemName: country.name,
        itemId: country.id,
        itemListId: country.id,
        itemListName: country.name);

    return FirebaseAnalytics.instance.logSelectItem(
        itemListId: country.id,
        itemListName: country.name,
        items: [analyticsItem]);
  }

  Future<void> city(CityModel city) {
    AnalyticsEventItem analyticsItem = AnalyticsEventItem(
        quantity: 1,
        itemName: city.name,
        itemId: city.id,
        itemListId: city.id,
        itemListName: city.name);

    return FirebaseAnalytics.instance.logSelectItem(
        itemListId: city.id, itemListName: city.name, items: [analyticsItem]);
  }
}
