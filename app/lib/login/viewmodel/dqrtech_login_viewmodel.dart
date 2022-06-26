import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/services/authentication_service.dart';
import 'package:flutter/material.dart';

class DqrtechLoginViewModel extends BaseModel {
  DqrtechLoginViewModel();

  final logo = Image.asset('assets/images/logo.png');

  final loginButton = const Text('Login',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ));

  final emailField = const InputDecoration(border: OutlineInputBorder(), labelText: 'Email');
  final emailController = TextEditingController();

  final passwordField = const InputDecoration(border: OutlineInputBorder(), labelText: 'Password');
  final passwordController = TextEditingController();

  doLogin() async {
    var authenticationService = DependencyBase.resolve<AuthenticationService>(AuthenticationService);
    if (emailController.text.isNotEmpty && emailController.text.isNotEmpty) {
      authenticationService.doLogin(emailController.value.text, passwordController.value.text);
    }
  }
}
