import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/routes.dart';
import 'package:dqrtech/services/navigator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  doLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (auth.currentUser != null) {
        doNavigateToHome();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   print('No user found for that email.'),
        // );
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   _showMessage('Wrong password provided for that user.'),
        // );
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  doLogout() {
    if (auth.currentUser != null) {
      auth.signOut().then((_) => doNavigateToLogin()).catchError((error) => debugPrint(error));
    }
  }

  doNavigateToHome() {
    var navigatorService = DependencyBase.resolve<NavigatorService>(NavigatorService);
    navigatorService.navigatorKey.currentState?.pushNamed(Routes.HOME);
  }

  doNavigateToLogin() {
    var navigatorService = DependencyBase.resolve<NavigatorService>(NavigatorService);
    navigatorService.navigatorKey.currentState?.pushNamed(Routes.LOGIN);
  }
}
