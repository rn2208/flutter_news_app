import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_application/news.dart';
import 'package:flutter_news_application/widget/news_list.dart';
import 'package:flutter_news_application/widget/search_bar.dart';

import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter News Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ApiService apiService;
  Stream<List<News>>? newsStream;

  @override
  initState() {
    super.initState();
    final dio = Dio();
    apiService = ApiService(dio);
  }

  void fetchNews([String? searchInput]) async {
    if (searchInput == null || searchInput == "") {
      return;
    }
    newsStream = apiService.getNewsStream(searchInput);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SearchBarWidget(fetchNews),
          if (newsStream != null) ...{
            NewsList(newsData: newsStream)
          }
        ],
      ),
    );
  }
}
