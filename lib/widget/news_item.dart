
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../news.dart';

class NewsItem extends StatelessWidget {
  final News? news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    bool drawImage = true;
    late Image image;
    if (news?.imageUrl != null) {
      image = Image.network(news!.imageUrl!, errorBuilder: (c,e,s) {
        drawImage = false;
        return SizedBox();
      });
    } else {
      drawImage = false;
    }

    return (news == null) ? Text("Not Load")
    : ListTile(
      onTap: () => launchUrl(Uri.parse(news!.url)),
      leading: (drawImage) ? image : null,
      title: Text(news!.title),
      subtitle: Text(news?.description ?? ""),
      trailing: Text(
        DateFormat(
          "hh:mm",
        ).format(DateTime.parse(news!.publishedAt)).toString(),
      ),
    );
  }
}
