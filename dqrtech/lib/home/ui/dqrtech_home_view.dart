import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/home/viewmodel/dqrtech_home_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../countries/ui/dqrtech_countries_view.dart';

class DqrtechHomeView extends StatelessWidget {
  const DqrtechHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DqrtechHomeViewModel>(
      viewModel: DqrtechHomeViewModel(),
      builder: (context, viewmodel) {
        return const Scaffold(
          body: DqrtechCountriesView(),
        );
      },
    );
  }
}
