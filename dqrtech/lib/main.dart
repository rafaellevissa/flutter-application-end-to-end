import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dqrtech/core/shell/dqrtech_app.dart';
import 'package:dqrtech/home/ui/dqrtech_home_view.dart';
import 'package:dqrtech/services/shell_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dqrtech/login/ui/dqrtech_login_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isIOS) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCRMb0HbCHHTI__kJt-wmYShT_py89iYFQ",
              appId: "1:812851367729:ios:00cd681eda22137d846a10",
              messagingSenderId: "812851367729",
              projectId: "dqrtech-9c9c7"));
    } else {
      await Firebase.initializeApp();
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    ShellService shellService = ShellService();

    await shellService.initApplication();

    Widget doHomeOrLogin() {
      if (FirebaseAuth.instance.currentUser != null) {
        return const DqrtechHomeView();
      }

      return const DqrtechLoginView();
    }

    // StorageService storageService = DependencyBase.resolve<StorageService>(StorageService);

    //Locking app orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) {
        return runApp(
          DqrtechApp(
            title: 'Dqrtech Starter',
            home: doHomeOrLogin(),
          ),
        );
      },
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
