import 'package:dqrtech/bootstraps/base_view.dart';
import 'package:dqrtech/login/viewmodel/dqrtech_login_viewmodel.dart';
import 'package:flutter/material.dart';

class DqrtechLoginView extends StatelessWidget {
  const DqrtechLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DqrtechLoginViewModel>(
      viewModel: DqrtechLoginViewModel(),
      builder: (context, viewmodel) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: SizedBox(
                          width: 200, height: 150, child: viewmodel.logo),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: viewmodel.emailField,
                      controller: viewmodel.emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 10),
                    child: TextField(
                      obscureText: true,
                      decoration: viewmodel.passwordField,
                      controller: viewmodel.passwordController,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewmodel.doLogin(),
                    child: viewmodel.loginButton,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
