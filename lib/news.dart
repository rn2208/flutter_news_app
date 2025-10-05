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
}
