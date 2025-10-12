import 'package:flutter/material.dart';
import 'package:flutter_news_application/main.dart';
import 'package:flutter_news_application/widget/news_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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

    //После ввода текста
    await tester.enterText(searchField, 'Moscow');

    // и нажатии на кнопку
    await tester.tap(searchButton);
    await tester.pump(Duration(seconds: 1));

    // поиска под поисковой строкой и кнопкой должен отображаться список найденных новостей
    var news = find.byType(NewsItem);

    expect(news, findsAny);

    // Если новостей не найдено, то должно выводиться сообщение «Новости не найдены»
    await tester.tap(searchField);
    await tester.pump(Duration(seconds: 1));

    await tester.enterText(searchField, 'agprqphjnephnqperoheh');
    await tester.tap(searchButton);

    await tester.pump(Duration(seconds: 1));
    var notFoundNews = find.text('Новости не найдены');

    expect(notFoundNews, findsOne);
    // по убыванию даты/времени публикации новости.
  });
}
