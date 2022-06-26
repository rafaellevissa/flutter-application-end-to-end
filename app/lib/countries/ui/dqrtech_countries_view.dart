import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/countries/viewmodel/dqrtech_countries_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DqrtechCountriesView extends StatelessWidget {
  const DqrtechCountriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DqrtechCountriesViewModel>(
      viewModel: DqrtechCountriesViewModel(),
      builder: (context, viewmodel) {
        return Scaffold(
          appBar: AppBar(title: Text(viewmodel.countriesText), actions: [
            IconButton(
                onPressed: () => viewmodel.doLogout(),
                icon: const Icon(Icons.exit_to_app))
          ]),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Selector<DqrtechCountriesViewModel, List<CountryModel>>(
                selector: (context, viewmodel) => viewmodel.countries,
                builder: (context, countries, child) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: countries.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(countries[index].name),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () =>
                            viewmodel.doNavigateToCities(countries[index]),
                      );
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
