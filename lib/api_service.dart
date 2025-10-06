import 'package:dio/dio.dart';

import 'news.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<News>> getNews(String theme) async {
    if( theme == "") {
      theme = 'Apple';
    }
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything?q=$theme&from=2025-10-01&sortBy=popularity&apiKey=d364d52b67854ed0978b336519f1480f',
      );
      final dataArticles = response.data['articles'] as List;
      final news = dataArticles.map((elem) {
        final String source = elem['source']['name'];
        final String? description = elem['description'];
        final String? urlToImage = elem['urlToImage'];
        final String url = elem['url'];
        final String publishedAt = elem['publishedAt'];
        final String title = elem['title'];
        return News(
          source: source,
          description: description,
          imageUrl: urlToImage,
          url: url,
          publishedAt: publishedAt,
          title: title,
        );
      }).toList();
      return news;
    } on DioException catch (e) {
      print('При выполнении запроса возникла ошибка: ${e.message}');
      rethrow;
    }
  }

  Stream<List<News>> getNewsStream(String theme) async* {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything?q=$theme&sortBy=publishedAt&apiKey=d364d52b67854ed0978b336519f1480f',
      );

      final dataArticles = response.data['articles'] as List;

      final news = dataArticles.map((elem) {
        final String source = elem['source']['name'];
        final String? description = elem['description'];
        final String? urlToImage = elem['urlToImage'];
        final String url = elem['url'];
        final String publishedAt = elem['publishedAt'];
        final String title = elem['title'];
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
