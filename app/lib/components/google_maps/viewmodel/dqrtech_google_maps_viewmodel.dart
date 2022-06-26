import 'dart:async';

import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_geocoding/google_geocoding.dart';

class DqrtechGoogleMapsViewModel extends BaseModel {
  DqrtechGoogleMapsViewModel(this.city, this.country, this.subcountry) {
    goToTheLake();
  }

  String city;
  String country;
  String subcountry;

  final Completer<GoogleMapController> _controller = Completer();
  late GeocodingResponse? _location;

  GeocodingResponse? get location => _location;

  LatLng center = const LatLng(45.521563, -122.677433);

  final List<Component> component = [];
  final GoogleGeocoding googleGeocoding =
      GoogleGeocoding("AIzaSyBWPgv_900oL5cPBTeY1Js1v_FDh7QYDbw");

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> goToTheLake() async {
    // analytics- TO-DO
    _location = await googleGeocoding.geocoding
        .get("$country, $subcountry, $city", component);

    var geometry = _location?.results?.first.geometry?.location;
    var lat = geometry?.lat ?? 45.521563;
    var lng = geometry?.lng ?? -122.677433;

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16.7),
      ),
    );
  }
}
