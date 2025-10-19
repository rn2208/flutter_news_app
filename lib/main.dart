import 'package:flutter/material.dart';
import 'package:flutter_news_application/page/news_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade200)),
      home: const NewsPage(title: 'Flutter News Application'),
    );
  }
}

