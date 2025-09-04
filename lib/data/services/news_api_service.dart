import 'package:crypto_price_list/data/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class NewsApiService {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: "news");

  Future<NewsModel> getNews({int page = 1, int pageSize = 20}) async {
    final response = await _dio.get(
      "everything",
      queryParameters: {
        "q": "cryptocurrency",
        "page": page,
        "pageSize": pageSize,
        "apiKey": "0860d3e2b70b4cb0bde8bfd301d92d4c",
      },
    );
    return NewsModel.fromJson(response.data);
  }
}
