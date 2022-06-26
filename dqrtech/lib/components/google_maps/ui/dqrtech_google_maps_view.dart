import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/components/google_maps/viewmodel/dqrtech_google_maps_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DqrtechGoogleMapsView extends StatelessWidget {
  const DqrtechGoogleMapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return BaseView<DqrtechGoogleMapsViewModel>(
      viewModel: DqrtechGoogleMapsViewModel(
          arguments['city']!, arguments['country']!, arguments['subcountry']!),
      builder: (context, viewmodel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Google Maps'),
          ),
          body: GoogleMap(
            onMapCreated: viewmodel.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: viewmodel.center,
              zoom: 11.0,
            ),
          ),
        );
      },
    );
  }
}
