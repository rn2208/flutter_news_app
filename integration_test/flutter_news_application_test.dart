import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_news_application/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Тестовое задание', (tester) async {
    // После запуска показывается экран
    await tester.pumpWidget(const MyApp());

    // с поисковой строкой
    Finder searchField = find.byKey(Key('search_field'));

    expect(searchField, findsOne);

    //и кнопкой поиска.

    Finder searchButton = find.byKey(Key('search_button'));

    expect(searchButton, findsOne);
  });
}
