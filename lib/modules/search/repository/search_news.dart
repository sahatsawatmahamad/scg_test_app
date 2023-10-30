import 'package:dio/dio.dart';
import 'package:scg_test_app/modules/search/models/news.dart';

class SearchNewsRepository {
  SearchNewsRepository();
  final dio = Dio();

  Future<News> getSearchNews(String keyword) async {
    final dateNow = DateTime.now();

    final re = await dio.get(
      'https://newsapi.org/v2/everything?q=$keyword&from=${dateNow.year - dateNow.month - dateNow.day}&sortBy=publishedAt&apiKey=79b90038528742b2909ee1eb7cc77114',
    );

    return News.fromJson(re.data);
  }
}
