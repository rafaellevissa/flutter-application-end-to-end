import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/cities/viewmodel/dqrtech_cities_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DqrtechCitiesView extends StatelessWidget {
  const DqrtechCitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return BaseView<DqrtechCitiesViewModel>(
      viewModel: DqrtechCitiesViewModel(arguments['countryId']!),
      builder: (context, viewmodel) {
        return Scaffold(
          appBar: AppBar(title: Text(viewmodel.citiesText), actions: [
            IconButton(
                onPressed: () => viewmodel.doLogout(),
                icon: const Icon(Icons.exit_to_app))
          ]),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Selector<DqrtechCitiesViewModel, List<CityModel>>(
                selector: (context, viewmodel) => viewmodel.cities,
                builder: (context, cities, child) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cities.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(cities[index].name),
                          trailing: const Icon(Icons.arrow_right),
                          onTap: () =>
                              viewmodel.doNavigateToGoogleMaps(cities[index]));
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
