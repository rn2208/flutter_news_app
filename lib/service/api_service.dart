import 'package:dio/dio.dart';

import '../dto/news.dart';

class ApiService {
  final Dio _dio = Dio();
  ApiService();

  Stream<List<News>> getNewsStream(String theme, [int pageSize = 10]) async* {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything?q=$theme&apiKey=d364d52b67854ed0978b336519f1480f&sortBy=publishedAt&pageSize=$pageSize',
      );

      final dataArticles = response.data['articles'] as List;

      final news = dataArticles.map((elem) {
        String source = elem['source']['name'];
        String? description = elem['description'];
        String? urlToImage = elem['urlToImage'];
        String url = elem['url'];
        String publishedAt = elem['publishedAt'];
        String title = elem['title'];
        return News(
          source: source,
          description: description,
          imageUrl: urlToImage,
          url: url,
          publishedAt: publishedAt,
          title: title,
        );
      }).toList();
      yield news;
    } on DioException catch (e) {
      print('При выполнении запроса возникла ошибка: ${e.message}');
      rethrow;
    }
  }
}
