import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/services/media_query_service.dart';
import 'package:dqrtech/services/navigator_service.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  final MediaQueryService _mediaQueryService =
      DependencyBase.resolve<MediaQueryService>(MediaQueryService);
  final NavigatorService _navigatorService =
      DependencyBase.resolve<NavigatorService>(NavigatorService);

  bool enableManualEntry = false;

  void enableManualEntryButton() {
    enableManualEntry = true;
  }

  ViewState get state => _state;

  MediaQueryService get mediaQueryService => _mediaQueryService;
  NavigatorService get navigatorService => _navigatorService;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

enum ViewState { Idle, Busy }
