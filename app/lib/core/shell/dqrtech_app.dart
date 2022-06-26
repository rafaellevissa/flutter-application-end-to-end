import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/core/shell/dqrtech_base_app_model.dart';
import 'package:dqrtech/core/shell/dqrtech_context_dependent_starter.dart';
import 'package:dqrtech/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt _locator = GetIt.instance;

class DqrtechApp extends StatefulWidget {
  final Widget? home;
  final ThemeData? appTheme;
  final String title;

  const DqrtechApp({Key? key, this.home, this.appTheme, required this.title}) : super(key: key);

  @override
  _DqrtechAppState createState() => _DqrtechAppState();
}

class _DqrtechAppState extends State<DqrtechApp> {
  final _navigatorKey = _locator<NavigatorService>().navigatorKey;

  // ThemeData _appTheme(model) =>
  //     widget.appTheme ??
  //     DefaultAppTheme.getThemeData(
  //       fontFamily: WLMData.instance.getValue("appThemeName"),
  //       linespacingValue: model.linespacingValue,
  //     );

  @override
  Widget build(BuildContext context) {
    return BaseView<DqrtechBaseAppModel>(
      viewModel: DqrtechBaseAppModel(),
      builder: (context, model) {
        return MaterialApp(
          routes: model.getRoutes(),
          navigatorKey: _navigatorKey,
          title: widget.title,
          home: DqrtechContextDependentStarter(
            child: Scaffold(
              body: widget.home,
            ),
          ),
        );
      },
    );
  }
}
