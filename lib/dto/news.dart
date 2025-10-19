class News {
  final String source;
  final String title;
  final String? description;
  final String? imageUrl;
  final String publishedAt;
  final String url;

  News({
    required this.title,
    required this.url,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> map) {
    return News(
      source: map['source']['name'],
      description: map['description'],
      imageUrl: map['urlToImage'],
      url: map['url'],
      publishedAt: map['publishedAt'],
      title: map['title'],
    );
  }
}
