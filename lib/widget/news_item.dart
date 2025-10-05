
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../news.dart';

class NewsItem extends StatelessWidget {
  final News? news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return (news == null) ? Text("Not Load")
    : ListTile(
      onTap: () => launchUrl(Uri.parse(news!.url)),
      leading: (news?.imageUrl != null) ? Image.network(news!.imageUrl!, errorBuilder: (c,e,s) => SizedBox()) : null,
      title: Text(news!.title),
      subtitle: Text(news?.description ?? ""),
      trailing: Text(
        DateFormat(
          "yyyy-MM-dd hh:mm:ss",
        ).format(DateTime.parse(news!.publishedAt)).toString(),
      ),
    );
  }
}
