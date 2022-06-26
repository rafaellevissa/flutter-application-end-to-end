import 'package:dqrtech/login/ui/dqrtech_login_view.dart';
import 'package:dqrtech/services/shell_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('LoginView', (WidgetTester tester) async {
    ShellService shellService = ShellService();

    await shellService.initApplication();

    const key = Key('loginView');

    await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: DqrtechLoginView(key: key))));

    expect(find.byKey(key), findsOneWidget);
    expect(find.byType(TextField), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
