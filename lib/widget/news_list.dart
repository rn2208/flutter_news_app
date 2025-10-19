import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../dto/news.dart';
import 'news_item.dart';

class NewsList extends StatelessWidget {
  final ScrollController scrollController;

  final List<News> newsData;

  const NewsList(this.newsData, this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    var newsGroupByDate = groupBy(newsData, (obj) => obj.publishedAt.substring(0, 10));

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: newsGroupByDate.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == newsGroupByDate.length) {
            return Center(child: SizedBox(width: 10, height: 10, child: CircularProgressIndicator()));
          }
          var date = newsGroupByDate.keys.elementAt(index);
          var newsInDate = newsGroupByDate[date];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.parse(date)).toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsInDate!.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return NewsItem(news: newsInDate[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
