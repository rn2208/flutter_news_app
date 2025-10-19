import 'package:flutter/material.dart';

import '../service/api_service.dart';
import '../dto/news.dart';
import '../widget/news_list.dart';
import '../widget/not_found_news.dart';
import '../widget/search_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.title});

  final String title;

  @override
  State<NewsPage> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  late ApiService apiService;
  Stream<List<News>>? newsStream;
  final ScrollController _scrollController = ScrollController();
  int perPage = 10;
  final searchInput = TextEditingController();
  List<News> news = [];
  bool showHint = false;

  @override
  initState() {
    super.initState();
    apiService = ApiService();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        perPage += 10;
        fetchNews(perPage);
        setState(() {});
      }
    });
  }

  void fetchNews([int perPage = 10]) {
    if (searchInput.text == "") {
      return;
    }
    apiService.getNewsStream(searchInput.text, perPage).listen((data) {
      news = data;
      showHint = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Column(
        children: [
          TopSearchBar(searchInput, fetchNews),
          (news.isNotEmpty)
              ? NewsList(news, _scrollController)
              : (showHint)
              ? NotFoundNews()
              : SizedBox(),
        ],
      ),
    );
  }
}

