import 'package:dqrtech/countries/ui/dqrtech_countries_view.dart';
import 'package:dqrtech/services/shell_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './mocks.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('CountriesView', (WidgetTester tester) async {
    ShellService shellService = ShellService();
    await shellService.initApplication();

    const key = Key('CountryView');

    await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: DqrtechCountriesView(key: key))));

    expect(find.byKey(key), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Countries'), findsOneWidget);
  });
}
