import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../news.dart';
import 'news_item.dart';

class NewsList extends StatelessWidget {
  final Stream<List<News>>? newsData;

  const NewsList({required this.newsData, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: newsData,
        builder: (context, asyncSnapshot) {
          List<News>? news = asyncSnapshot.data;

          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!asyncSnapshot.hasData || news!.isEmpty) {
            return Column(
              spacing: 20,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/images/quad.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Новости не найдены',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            );
          }

          var newsGroupByDate = groupBy(
            news,
            (obj) => obj.publishedAt.substring(0, 10),
          );

          return ListView.builder(
            itemCount: newsGroupByDate.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var date = newsGroupByDate.keys.elementAt(index);
              var newsInDate = newsGroupByDate[date];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd()
                        .format(DateTime.parse(date))
                        .toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: newsInDate!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return NewsItem(news: newsInDate[index]);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
