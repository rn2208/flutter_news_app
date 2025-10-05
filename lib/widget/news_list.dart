import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../news.dart';
import 'news_item.dart';

class NewsList extends StatelessWidget {
  final Stream<List<News>>? newsData;

  const NewsList({required this.newsData, super.key});

  @override
  Widget build(BuildContext context) {
    // var newsGroupByDate = groupBy(newsData, (obj) => obj.publishedAt.substring(0, 10));
    return Expanded(
      child: StreamBuilder(
        stream: newsData,
        builder: (context, asyncSnapshot) {
          List<News>? news = asyncSnapshot.data;
          if (!asyncSnapshot.hasData || news!.isEmpty) {
            return Column(
              spacing: 20,
              children: [
                Text(
                  'Новости не найдены',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/images/quad.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }

          return ListView.separated(
            itemBuilder: (ctx, index) {
              return NewsItem(news: news[index]);
            },
            itemCount: news.length,
            separatorBuilder: (ctx, index) => const Divider(),
          );
        },
      ),
    );
  }
}
